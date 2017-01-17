library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

package utils is

--  Convert integer in signed integer format to integer in offest binary format
    function si2ob (signed_integer: std_logic_vector(7 downto 0)) return std_logic_vector;

--  Convert integer in offest binary format to integer in signed integer format
    function ob2si (offset_binary: std_logic_vector(7 downto 0)) return std_logic_vector;

--  Convert character to it's lcd bus code
    function char2lcd (char: character) return std_logic_vector;

    subtype ranged_count is integer range -99 to 99;

end package;

package body utils is
    
    function si2ob (signed_integer: std_logic_vector(7 downto 0)) return std_logic_vector is
    begin
        return signed_integer + 128;
    end function;
    
    function ob2si (offset_binary: std_logic_vector(7 downto 0)) return std_logic_vector is
    begin
        return offset_binary + 128;
    end function;
    
    function char2lcd (char: character) return std_logic_vector is
    begin
        return conv_std_logic_vector(character'pos(char), 8);
    end function;
    
end package body;