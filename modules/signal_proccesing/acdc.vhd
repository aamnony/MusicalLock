library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use work.utils.all;

-- should we also use ABS? Asaf thinks it will improve performance
-- all calculations are done in si (signed integer) format
entity acdc is
generic
(
    FADE_COEF: integer range 1 to 100 := 2
);
port
(
    resetN: in std_logic;
    clk: in std_logic;
    ac: in std_logic_vector(7 downto 0);
    dc: out std_logic_vector(7 downto 0)
);
end entity;

architecture arc_acdc of acdc is    
    signal dc_i: std_logic_vector(7 downto 0);
begin
    dc <= dc_i;
process (clk, resetN)
    variable fade: integer range 1 to FADE_COEF := 1;
begin
    if resetN = '0' then
        dc_i <= ( others => '0' );
        fade := 1;
    elsif rising_edge(clk) then
        if ac >= dc_i then
            dc_i <= ac;
            fade := 1;
        elsif fade = 1 then
            if dc_i > 0 then
                dc_i <= dc_i - 1;
                fade := FADE_COEF;
            end if;
        else
            fade := fade - 1;
        end if;
    end if;
end process;
end architecture;
