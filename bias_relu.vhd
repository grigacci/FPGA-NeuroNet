library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_relu_mem.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity bias_relu is
    generic (
        instance_number : integer
    );

    port (
        data_in_bias_relu            : in bfloat16;    
        clk_bias_relu                : in std_logic;

        data_o_bias_relu             : out bfloat16;
        clk_o_bias_relu              : out std_logic
    );
end bias_relu;

architecture comportamental of bias_relu is
    signal bias_relu : float(0 downto -weight_size + 1) := relu_bias(instance_number);
    signal aux  : bfloat16;
begin
    process(data_in_bias_relu,clk_bias_relu)
    begin
        aux <= data_in_bias_relu + bias_relu;
        data_o_bias_relu <= aux;
        clk_o_bias_relu <= clk_bias_relu;
    end process;
end comportamental;
