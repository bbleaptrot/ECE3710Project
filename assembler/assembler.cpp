/*
 * Simple assembler for Group 9, ECE 3710, Fall 2020
 * Group Members: Ben Leaptrot, Christian Giauque, Colton Watson, Nathan Hummel
 *
 * Notes for Future Reference:
 *   >How should labels be handled?
 *     array of them with instruction they start at?
 *     mapping of string -> address?
 *     don't bother because B/Jcond/JAL don't work like that?
 *
 * Last updated: October 16, 2020
 */

#include <cstdlib>
#include <iostream> 
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

#include <iomanip>

bool arg_check(int argc, char** argv);
std::vector<std::string> get_asm_lines(char* filename);
std::string trim(std::string& line);
short parse_line(std::string& line);
bool undefined_code(short code);
int reg_to_char(std::string reg);

int main(int argc, char** argv)
{
  // Make sure arguments are good.
  if(!arg_check(argc, argv))
    return -1;

  // Store every line into a vector.
  std::vector<std::string> asm_lines = get_asm_lines(argv[1]);

  if(!asm_lines.size()) return -1;

  // Parse each line.
  for(int i = 0; i < asm_lines.size(); i++)
  {
    std::cout << "Parsing line: " << asm_lines[i] << std::endl;
    short asm_code = parse_line(asm_lines[i]);

    if(undefined_code(asm_code))
    {
      std::cout << asm_lines[i] << std::endl;
      return asm_code; 
    }
  
    std::cout << "     " << std::hex << std::setfill('0') << std::setw(4) << asm_code << std::endl;
    //printf("%04X\n", asm_code); // "But it's not type-safe! Glorious C++ is above!" - Some Strictly C++ Dude.
  }

  return 0;
}


/*
 * Simple command-line argument checker. 
 * The program expects a filename for the second input.
 *
 */
bool arg_check(int argc, char** argv)
{
  if(argc < 2)
  {
    std::cout << "Not enough arguments" << std::endl;
    return false;
  }
  return true;
}


/*
 * Simple utility function to get every line of asm code into a single vector
 * of commands. Ignores newlines and comments.
 *
 */
std::vector<std::string> get_asm_lines(char* filename)
{
  std::vector<std::string> asm_lines;
  std::string line;
  std::ifstream asm_file (filename);
  
  if(asm_file.is_open())
  {
    while(getline(asm_file, line))
    {
      std::string temp = trim(line);
      if(!temp.empty())
        asm_lines.push_back(temp);
    }
  }
  else
  {
    std::cout << "Unable to open file: '" << filename << "'" << std::endl;
  }

  return asm_lines;
}


/*
 * Trims a string to remove trailing whitespace and comments.
 *
 */
std::string trim(std::string& line)
{
  if(line.empty()) return line;

  std::string wspace (" \t\f\v\n\r");  
  std::string trimmed_line = line;  

  // Trim leading whitespace. 
  trimmed_line.erase(0, trimmed_line.find_first_not_of(wspace));
  if(trimmed_line.empty()) return trimmed_line;
 
  // Remove comments.
  std::size_t comment = trimmed_line.find_first_of('#');
  if(comment != std::string::npos)
  {
    trimmed_line.erase(comment, std::string::npos);
    if(trimmed_line.empty()) return trimmed_line;
  }

  // Trim trailing whitespace.
  std::size_t end_char = trimmed_line.find_last_not_of(wspace);
  if(end_char != std::string::npos)
  {
    trimmed_line.erase(end_char + 1, std::string::npos);
  }

  return trimmed_line;
}


/*
 * Parses a single line and gives assembly equivalent, if possible.
 * 
 * Errors are present in unused codes. 0x4yFy are error codes. 
 *   0x4FFF - Invalid operation.
 *   0x4FFE - Invalid operands
 */
short parse_line(std::string& line)
{
  std::stringstream line_stream(line);
  std::string instr;

  if(!(line_stream >> instr))
    return 0x4FFF;

  // Welcome to string compare hell! Who needs a fancy case statement in C++?
  // ififififififififififififififififififif
  if(!instr.compare("ADD"))
  {
    std::string Rsrc;
    std::string Rdest;
 
    if(!((line_stream >> Rsrc) && (line_stream >> Rdest)))
      return 0x4FFE;
   
    int Rd = reg_to_char(Rdest);
    int Rs = reg_to_char(Rsrc);
 
    if((Rs > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x0 + (Rd << 8) + (0x5 << 4) + (Rs);   
  }

  if(!instr.compare("ADDI"))
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return (0x5 << 12) + (Rd << 8) + Imm;
  }
  if(!instr.compare("ADDU"))
  {
    std::string Rsrc;
    std::string Rdest;

    if(!((line_stream >> Rsrc) && (line_stream >> Rdest)))
      return 0x4FFE;

    int Rd = reg_to_char(Rdest);
    int Rs = reg_to_char(Rsrc);
  
    if((Rs > 15) || (Rd > 15))
      0x4FFE;

    return (0x0) + (Rd << 8) + (0x6 << 4) + (Rs);
  }
  if(!instr.compare("ADDUI"))
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return (0x6 << 12) + (Rd << 8) + Imm;
  }
  //if(!instr.compare("ADDC")) {...}
  //if(!instr.compare("ADDCI")) {...}
  if(!instr.compare("SUB"))
  {
    std::string Rsrc;
    std::string Rdest;
 
    if(!((line_stream >> Rsrc) && (line_stream >> Rdest)))
      return 0x4FFE;
    
    int Rd = reg_to_char(Rdest);
    int Rs = reg_to_char(Rsrc);
 
    if((Rs > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x0 + (Rd << 8) + (0x9 << 4) + (Rs);   
  }
  if(!instr.compare("SUBI"))
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return (0x9 << 12) + (Rd << 8) + Imm;
  }
  //if(!instr.compare("SUBC"))
  //if(!instr.compare("SUBCI"))
  if(!instr.compare("CMP"))
  {
    std::string Rsrc;
    std::string Rdest;
 
    if(!((line_stream >> Rsrc) && (line_stream >> Rdest)))
      return 0x4FFE;
    
    int Rd = reg_to_char(Rdest);
    int Rs = reg_to_char(Rsrc);
 
    if((Rs > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x0 + (Rd << 8) + (0xB << 4) + (Rs);   
  }
  if(!instr.compare("CMPI"))
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return (0xB << 12) + (Rd << 8) + Imm;
  }
  if(!instr.compare("AND"))
  {
    std::string Rsrc;
    std::string Rdest;
 
    if(!((line_stream >> Rsrc) && (line_stream >> Rdest)))
      return 0x4FFE;
    
    int Rd = reg_to_char(Rdest);
    int Rs = reg_to_char(Rsrc);
 
    if((Rs > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x0 + (Rd << 8) + (0x1 << 4) + (Rs);   
  }
  if(!instr.compare("ANDI"))
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return (0x1 << 12) + (Rd << 8) + Imm;
  }
  if(!instr.compare("OR"))
  {
    std::string Rsrc;
    std::string Rdest;
 
    if(!((line_stream >> Rsrc) && (line_stream >> Rdest)))
      return 0x4FFE;
    
    int Rd = reg_to_char(Rdest);
    int Rs = reg_to_char(Rsrc);
 
    if((Rs > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x0 + (Rd << 8) + (0x2 << 4) + (Rs);   
  }
  if(!instr.compare("ORI"))
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return (0x2 << 12) + (Rd << 8) + Imm;
  }
  if(!instr.compare("XOR"))
  {
    std::string Rsrc;
    std::string Rdest;
 
    if(!((line_stream >> Rsrc) && (line_stream >> Rdest)))
      return 0x4FFE;
    
    int Rd = reg_to_char(Rdest);
    int Rs = reg_to_char(Rsrc);
 
    if((Rs > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x0 + (Rd << 8) + (0x3 << 4) + (Rs);   
  }
  if(!instr.compare("XORI"))
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return (0x3 << 12) + (Rd << 8) + Imm;
  }
  if(!instr.compare("MOV"))
  { 
    std::string Rsrc;
    std::string Rdest;
 
    if(!((line_stream >> Rsrc) && (line_stream >> Rdest)))
      return 0x4FFE;
    
    int Rd = reg_to_char(Rdest);
    int Rs = reg_to_char(Rsrc);
 
    if((Rs > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x0 + (Rd << 8) + (0xD << 4) + (Rs);   
  }
  if(!instr.compare("MOVI")) 
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return (0xD << 12) + (Rd << 8) + Imm;
  }

  if(!instr.compare("LSH"))
  {
    std::string Ramount;
    std::string Rdest;
 
    if(!((line_stream >> Ramount) && (line_stream >> Rdest)))
      return 0x4FFE;
    
    int Rd = reg_to_char(Rdest);
    int Ra = reg_to_char(Ramount);
 
    if((Ra > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x8000 + (Rd << 8) + (0x4 << 4) + (Ra);   
  }

  if(!instr.compare("LSHI"))
  { 
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    int op_ext = 0;
    if(Imm < 0)
    {
      op_ext = 1;
      Imm = -Imm;
    }

    Imm = Imm & 0x000F;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return 0x8000 + (Rd << 8) + (op_ext << 4) + Imm;
  }
  if(!instr.compare("ASHU")) 
  {
    std::string Ramount;
    std::string Rdest;
 
    if(!((line_stream >> Ramount) && (line_stream >> Rdest)))
      return 0x4FFE;
    
    int Rd = reg_to_char(Rdest);
    int Ra = reg_to_char(Ramount);
 
    if((Ra > 15) || (Rd > 15))
      return 0x4FFE;
    
    //     Op     Rdest       OPext        Rsrc
    return 0x8000 + (Rd << 8) + (0x6 << 4) + (Ra);   
  }
  if(!instr.compare("ASHUI"))
  { 
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    int op_ext = 0;
    if(Imm < 0)
    {
      op_ext = 1;
      Imm = -Imm;  
    }
    Imm = Imm & 0x000F;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return 0x8020 + (Rd << 8) + (op_ext << 4) + Imm;
  }

  if(!instr.compare("LUI"))
  {
    std::string Rdest;
    int Imm;

    if(!(line_stream >> std::setbase(0) >> Imm))
      return 0x4FFE;
    line_stream >> Rdest;
    if(!((line_stream >> Rdest)))
      return 0x4FFE;

    Imm = Imm & 0x00FF;

    int Rd = reg_to_char(Rdest);

    if(Rd > 15)
      return 0x4FFE;

    return 0xF000 + (Rd << 8) + Imm;
  }
  
  if(!instr.compare("JAL"))
  { 
    std::string Rlink;
    std::string Rtarget;
 
    if(!((line_stream >> Rlink) && (line_stream >> Rtarget)))
      return 0x4FFE;
    
    int Rt = reg_to_char(Rtarget);
    int Rl = reg_to_char(Rlink);
 
    if((Rt > 15) || (Rl > 15))
      return 0x4FFE;
    
    //     Op     Rlink       OPext        Rtarget
    return 0x4000 + (Rl << 8) + 0x0080 + (Rt);   
  }
  // Just need Jumps and Branches...
  return 0;
}

int reg_to_char(std::string reg)
{
  std::string numbers("0123456789");
  reg = reg.substr(reg.find_first_of(numbers), reg.find_last_of(numbers));
  return atoi(reg.c_str());
}

/*
 * Return true if the code is undefined.
 * Return false if the code is not an error code.
 * Currently used error code:
 *   0x4FFF - Invalid operation
 *   0x4FFE - Invalid operands
 */
bool undefined_code(short code)
{
  switch(code)
  {
    case 0x4FFE : 
      std::cout << "Invalid operand arguments for: ";
      return true;
      break; // Probably unnessary, but the compiler probably doesn't even include this.

    case 0x4FFF : 
      std::cout << "Invalid instruction: ";
      return true;
      break;

    default: return false;
  }
}
