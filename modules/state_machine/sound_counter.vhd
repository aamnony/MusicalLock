library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use work.utils.all;

entity sound_counter is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    enable: in std_logic; -- output from clk_divider = 100Hz
    sound: in std_logic;
    valid: out std_logic;
    count: out ranged_count
);
end entity;

architecture arc_sound_counter of sound_counter is
    signal valid_i: std_logic;
    signal count_i: integer range -500 to 500;
begin
    valid <= valid_i;
    count <= count_i;
process (clk, resetN)
    variable prev_sound: std_logic := '0';
begin
    if resetN = '0' then
        valid_i <= '0';
        count_i <= 0;
    elsif rising_edge(clk) then
        if valid_i = '1' then
            count_i <= 0;
        end if;
        valid_i <= '0';
        if enable = '1' then
            if not (prev_sound = sound) then
                valid_i <= '1';
            elsif prev_sound = '1' then
                count_i <= count_i + 1;
            else
                count_i <= count_i - 1;
            end if;
            prev_sound := sound;
        end if;
    end if;
end process;
end architecture;