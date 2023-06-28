library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity output_softmax is
    port (
        data_in_output_softmax        : in bus_bfloat16(output_classes - 1 downto 0);    
        clk_output_softmax            : in std_logic;

        data_o_output_softmax          : out std_logic_vector(3 downto 0);
        clk_o_output_softmax           : out std_logic
    );
end output_softmax;

architecture comportamental of output_softmax is
    signal max : bfloat16 := ((others => '0'));
begin
    process(data_in_output_softmax,clk_output_softmax)
    begin
        for i in 0 to output_classes - 1 loop 
            if (data_in_output_softmax(i) > max) then
                max <= data_in_output_softmax(i);
            end if;
        end loop; 
    clk_o_output_softmax <= clk_output_softmax ;
    data_o_output_softmax <= to_slv(max)(data_o_output_softmax'length -1 downto 0);
    end process;
end comportamental;