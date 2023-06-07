library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity acummulator is
    port (
        data_in_acc         : in std_logic_vector(data_size - 1 downto 0);    
        done_in_acc         : in std_logic;
        clk_acc             : in std_logic;

        data_o_acc        : out std_logic_vector(data_size - 1 downto 0);
        clk_o_acc           : out std_logic
    );
end acummulator;

architecture comportamental of acummulator is
variable parcial : integer := 0;
signal last_value : std_logic_vector(data_size - 1 downto 0);
begin
    process(data_in_acc,done_in_acc,clk_acc)
    begin
        if (done_in_acc = '0')  then
            parcial := parcial + to_integer(signed(data));

        else 
            last_value <= std_logic_vector(to_signed(parcial, data_o_acc'length));

        end if;
    clk_o_acc <= clk_acc;
    data_o_acc <= last_value;
    end process;
end comportamental;
