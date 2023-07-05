library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.CONFIG.ALL;
use work.mulmat_relu_mem.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity neuron_relu is 
    generic (
        neuron_number: integer
    );

    port (
        data    : in bfloat16;
        address : in std_logic_vector(address_size - 1 downto 0);  
        clk     : in std_logic;
        --ready_in: in std_logic_vector(output_classes - 1 downto 0);
        
        data_o  : out bfloat16;
        ready_o : out std_logic
    );
end neuron_relu;

architecture comportamental of neuron_relu is
    --declaring all internal components 

    component mulmat_relu is
        generic (
            instance_number : integer
        );

        port (
            data_in_mulmat        : in bfloat16;    
            addr_in_mulmat        : in std_logic_vector(address_size - 1 downto 0);
            clk_in_mulmat            : in std_logic;
    
            data_out_mulmat       : out bfloat16;
            done_o_mulmat         : out std_logic
        );
    end component;

    component acummulator is 
        port (
            data_in_acc         : in bfloat16;    
            done_in_acc         : in std_logic;
            clk_acc             : in std_logic;
    
            data_o_acc          : out bfloat16
        );
    end component;

    component bias_relu is 
        generic (
            instance_number : integer
        );

        port (
            data_in_bias_relu            : in bfloat16;    
            clk_bias_relu                : in std_logic;
    
            data_o_bias_relu             : out bfloat16
        );
    end component;

    component relu is 
        port (
            clk_relu       : in std_logic;
            data_in_relu   : in bfloat16;
            
            data_o_relu    : out bfloat16
        );
    end component;

    signal aux_data_o_mulmat : bfloat16;
    signal aux_done_o_mulmat : std_logic;
    signal aux_data_o_acc    : bfloat16;
    signal aux_data_o_bias_relu   : bfloat16;

begin

    instancia_mulmat : component mulmat_relu
        generic map (
            instance_number => neuron_number
        )

        port map(
            --input----------------
            data_in_mulmat => data,
            addr_in_mulmat => address,
            clk_in_mulmat => clk,

            --output---------------
            data_out_mulmat => aux_data_o_mulmat,
            done_o_mulmat => aux_done_o_mulmat
        );
    
    instancia_acummulator : component acummulator
        port map(
            --input----------------
            data_in_acc => aux_data_o_mulmat,
            done_in_acc => aux_done_o_mulmat,
            clk_acc => clk,

            --output---------------
            data_o_acc => aux_data_o_acc
        );

    instancia_bias_relu : component bias_relu 
        generic map (
            instance_number => neuron_number
        )

        port map (
            --input----------------
            data_in_bias_relu => aux_data_o_acc,
            clk_bias_relu => clk,

            --output---------------
            data_o_bias_relu => aux_data_o_bias_relu
        );

    instancia_relu : component relu 
        port map (
            --input----------------
            data_in_relu => aux_data_o_bias_relu,
            clk_relu => clk,

            --output---------------
            data_o_relu => data_o
        );

end architecture;