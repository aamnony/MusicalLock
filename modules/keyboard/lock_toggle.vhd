library ieee;
use ieee.std_logic_1164.all;

entity lock_toggle is
port 
( 
    resetN: in std_logic;
    clk: in std_logic;
    full_key_code: in std_logic_vector (8 downto 0);
    pressed: in std_logic;
    released: in std_logic;
    compared_key_code: in std_logic_vector (7 downto 0);
    toggle: out std_logic
);
end entity;

architecture arc_lock_toggle of lock_toggle is
    signal locked: std_logic;
    signal toggle_i: std_logic;
begin
    toggle <= toggle_i;
process (clk, resetN)
begin
    if resetN = '0' then
        toggle_i <= '0';
        locked <= '0';
    elsif rising_edge(clk) then
        if compared_key_code = full_key_code(7 downto 0) 
                and pressed = '1' and locked = '0' then
            locked <= '1';
            toggle_i <= not toggle_i;
        elsif compared_key_code = full_key_code(7 downto 0) 
                and released = '1' then
            locked <= '0';
        end if;
    end if;
end process;
end architecture;