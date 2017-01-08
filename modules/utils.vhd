library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

package utils is

    function si2ob (signed_integer: std_logic_vector(7 downto 0))
        return std_logic_vector;
        
    function ob2si (offset_binary: std_logic_vector(7 downto 0))
        return std_logic_vector;
        
    subtype ranged_count is integer range -500 to 500;
    
    type ranged_count_array is array(integer range <>) of ranged_count;

end package;

package body utils is
    
    function si2ob (signed_integer: std_logic_vector(7 downto 0)) 
        return std_logic_vector is
    begin
        return signed_integer + 128;
    end function;
    
    function ob2si (offset_binary: std_logic_vector(7 downto 0)) 
        return std_logic_vector is
    begin
        return offset_binary + 128;
    end function;
    
end package body;