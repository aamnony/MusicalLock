-- BCD to 7-Segment (active low) � vector out
library ieee;
use ieee.std_logic_1164.all;

entity bcd2ss is
port
(
    bcd: in std_logic_vector(3 downto 0);
    all_off: in std_logic;
    all_on: in std_logic;
    ss: out std_logic_vector(6 downto 0)
);
end entity;

architecture arc_bcd2ss of bcd2ss is
begin
process (all_off, all_on, bcd)
begin
    if all_off = '1' then
        ss <= ( others => '0' );
    elsif all_on = '1' then
        ss <= ( others => '1' );
    else
        case bcd is
        when x"0" =>
            ss <= "0000001";
        when x"1" =>
            ss <= "1001111";
        when x"2" =>
            ss <= "0010010";
        when x"3" =>
            ss <= "0000110";
        when x"4" =>
            ss <= "1001100";
        when x"5" =>
            ss <= "0100100";
        when x"6" =>
            ss <= "0100000";
        when x"7" =>
            ss <= "0001111";
        when x"8" =>
            ss <= "0000000";
        when x"9" =>
            ss <= "0000100";
        when x"A" =>
            ss <= "0001000";
        when x"B" =>
            ss <= "1100000";
        when x"C" =>
            ss <= "0110001";
        when x"D" =>
            ss <= "1000010";
        when x"E" =>
            ss <= "0110000";
        when x"F" =>
            ss <= "0111000";
        when others =>
            null;
        end case;
    end if;
end process;
end architecture;