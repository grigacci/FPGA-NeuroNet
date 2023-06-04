library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity acummulator is
    port (
        data_in_acc         : in std_logic_vector(data_size - 1 downto 0);    
        done_in_acc         : in std_logic;
        clk_acc             : in std_logic;

        data_out_acc        : out std_logic_vector(data_size - 1 downto 0);
        data_valid_out_acc  : out std_logic;

        clk_o_acc           : out std_logic
    );
end acummulator;

architecture comportamental of acummulator is
variable parcial : integer :=0 ;
begin
    process(data_in_acc,done_in_acc,clk_acc)
    begin
        if (done_in_acc = '0')  then

            parcial := parcial + to_integer(unsigned(data));

        else 

            data_out_acc <= std_logic_vector(to_unsigned(parcial, data_out_acc'length));
            data_valid_out_acc  <= '1';

        end if;
    clk_o_acc <= clk_acc;
    end process;
end comportamental;
