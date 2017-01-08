library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity freq_compare is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    enable: in std_logic;
    autocorr: in std_logic_vector(31 downto 0);
    correct_freq: out std_logic
);
end entity;

architecture arc_freq_compare of freq_compare is
    constant TRESHOLD: integer := 1500000000;
begin
process (clk, resetN)
begin
    if resetN = '0' then
        correct_freq <= '0';
    elsif rising_edge(clk) then
		if enable = '1' then
			if autocorr >= TRESHOLD then
				correct_freq <= '1';
			else
				correct_freq <= '0';
			end if;
		end if;
    end if;
end process;
end architecture;