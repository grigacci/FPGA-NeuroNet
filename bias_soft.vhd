library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_soft_mem.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity bias_soft is
    generic (
        instance_number : integer
    );

    port (
        data_in_bias            : in bfloat16;    
        clk_bias                : in std_logic;

        data_o_bias             : out bfloat16;
        clk_o_bias              : out std_logic
    );
end bias_soft;

architecture comportamental of bias_soft is
    signal bias_soft : float(0 downto -weight_size + 1) := soft_bias(instance_number);
    signal aux  : bfloat16;
begin
    process(data_in_bias,clk_bias)
    begin
        aux <= data_in_bias + bias_soft;
        data_o_bias <= aux;
        clk_o_bias <= clk_bias;
    end process;
end comportamental;
