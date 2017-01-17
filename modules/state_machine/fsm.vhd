library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use work.utils.all;

entity fsm is
port
(
    resetN: in std_logic;
    clk: in std_logic;
    valid: in std_logic;
    count: in ranged_count;
    success: out std_logic;
    failure: out std_logic;
    which_password_index: out integer range 0 to 99;
    index_in_password: out integer range 1 to 99;
    first_sound: out std_logic := '0'
);
end entity;

architecture arc_fsm of fsm is
--  Each password must begin with a sound (positive number), and then 
--  alternate between sound and silence.
    constant PASSWORD_LENGTH: integer range 1 to 99 := 3;
    
    constant NUMBER_OF_PASSWORDS: integer range 1 to 99 := 3;
    
--  The first sound MUST be different for each password:
--  in the first instance of check_data state, we check which password
--  begins with the sampled sound, and after that we never check the
--  the other passwords.
    type type_2d_ranged_count_array 
         is array(1 to NUMBER_OF_PASSWORDS, 1 to PASSWORD_LENGTH) of ranged_count;
         
    constant PASSWORDS: type_2d_ranged_count_array :=
    (
        ( 30, -40, 30 ), 
        ( 10, -20, 10 ),
        ( 20, -10, 40 )
    );
    
    constant ERROR_MARGIN: natural := 5;
    
    type state_type is (reset, idle, check_data, failure_state, success_state);
    
    signal curr_state: state_type := reset;

    signal which_password_index_i: integer range 0 to NUMBER_OF_PASSWORDS := 0;
    signal index_in_password_i: integer range 1 to PASSWORD_LENGTH := 1;
    
begin
    which_password_index <= which_password_index_i;
    index_in_password <= index_in_password_i - 1; -- output the last detected index
process (clk, resetN)
begin
    if resetN = '0' then
        curr_state <= reset;
        index_in_password_i <= 1;
        which_password_index_i <= 0;
        first_sound <= '0';
    elsif rising_edge(clk) then
        success <= '0';
        failure <= '0';
        case curr_state is
            when reset =>
                index_in_password_i <= 1;
                which_password_index_i <= 0;
                first_sound <= '0';
                if valid = '1' then
                    curr_state <= idle;
                else
                    curr_state <= reset;
                end if;
            when idle =>
                first_sound <= '1';
                if count = -99 then
                    curr_state <= reset;
                elsif valid = '1' then
                    curr_state <= check_data;
                else
                    curr_state <= idle;
                end if;
            when check_data =>
--              First check which password (if any) to select by testing 
--              the first element in each password.
                if which_password_index_i = 0 then
                    for i in 1 to NUMBER_OF_PASSWORDS loop
                        if abs(count - PASSWORDS(i, 1)) <= ERROR_MARGIN then
                            which_password_index_i <= i;
                            curr_state <= idle;
                            index_in_password_i <= index_in_password_i + 1;
                            exit; -- exit loop
                        else
                            curr_state <= check_data;
                        end if;
                    end loop;
--              If we found a password, next times we'll check the other
--              elements in the password.
                elsif abs(count - PASSWORDS(which_password_index_i, index_in_password_i)) 
                        <= ERROR_MARGIN then
                    if index_in_password_i = PASSWORD_LENGTH then
                        curr_state <= success_state;
                    else
                        curr_state <= idle;
                        index_in_password_i <= index_in_password_i + 1;
                    end if;
                else
                    curr_state <= failure_state;
                end if;
            when failure_state =>
                failure <= '1';
                curr_state <= failure_state;
            when success_state =>
                success <= '1';
                curr_state <= success_state;
            end case;
    end if;
end process;

end architecture;