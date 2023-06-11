library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;
use work.bus_multiplexer_pkg.ALL;

entity output_softmax is
    port (
        data_in_output_softmax        : in bus_array(output_classes - 1 downto 0)(data_size - 1 downto 0);    
        clk_output_softmax            : in std_logic;

        data_o_output_softmax          : out std_logic_vector(3 downto 0);
        clk_o_output_softmax           : out std_logic
    );
end output_softmax;

architecture comportamental of output_softmax is
    signal max : std_logic_vector(data_size - 1 downto 0) := ((others => '0'));
begin
    process(data_in_output_softmax,clk_output_softmax)
    begin
        for i in 0 to output_classes -1 loop 
            if (data_in_output_softmax(i) > max) then
                max <= data_in_output_softmax(i);
            end if;
        end loop; 
    clk_o_output_softmax <= clk_output_softmax ;
    data_o_output_softmax <= max;
    end process;
end comportamental;