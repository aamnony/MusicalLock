library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram_counter is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    enable: in std_logic;
    count: out std_logic_vector(9 downto 0);
    count_plus_1: out std_logic_vector(9 downto 0)
);
end entity;

architecture arc_ram_counter of ram_counter is
    constant MAX_COUNT: integer := 5;
    signal count_i: std_logic_vector(9 downto 0);
begin
    count <= count_i;
    count_plus_1 <= (count_i + 1) when count_i < MAX_COUNT else (others => '0');
process (clk, resetN)
begin
    if resetN = '0' then
        count_i <= (others => '0');
    elsif rising_edge(clk) then
		if enable = '1' then
			if count_i >= MAX_COUNT then
				count_i <= (others => '0');
			else
				count_i <= count_i + 1;
			end if;
        end if;
    end if;
end process;
end architecture;