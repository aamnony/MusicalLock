library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity key_pressed_detector is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    make: in std_logic;
    break: in std_logic;
    is_pressed: out std_logic
    
);
end entity;

architecture arc_key_pressed_detector of key_pressed_detector is
    signal is_pressed_i: std_logic;
begin

process (clk, resetN)
begin
    if resetN = '0' then
        is_pressed <= '0';
    elsif rising_edge(clk) then
        if make = '1' then
            is_pressed <= '1';
        elsif break = '1' then
            is_pressed <= '0';
        end if;
    end if;
end process;

end architecture;
