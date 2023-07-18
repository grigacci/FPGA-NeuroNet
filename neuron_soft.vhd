library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.CONFIG.ALL;
use work.mulmat_soft_mem.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity neuron_soft is 
    generic (
        neuron_number: integer
    );

    port (
        data    : in bus_bfloat16(number_of_neurons - 1 downto 0);
        address : in std_logic_vector(address_size - 1 downto 0);  
        clk     : in std_logic;

        data_o  : out bfloat16
    );
end neuron_soft;

architecture comportamental of neuron_soft is
    --declaring all internal components 
    component mux_soft is 
        generic (
            instance_number : integer
        );
    
        port (
            data_in_mux_soft : in bus_bfloat16(number_of_neurons - 1 downto 0);
            
            addr_in_mux_soft : in std_logic_vector(address_size - 1 downto 0);
            clk_mux_soft     : in std_logic;
    
            data_o_mux_soft : out bfloat16;
            connection_o_mux_soft : out std_logic_vector(5 downto 0)
        );
    end component;

    component mulmat_soft is
        generic (
            instance_number : integer
        );

        port (
            data_in_mulmat_soft        : in bfloat16;    
            connection_in_mulmat_soft        : in std_logic_vector(5 downto 0);
            clk_mulmat_soft            : in std_logic;
    
            data_o_mulmat_soft         : out bfloat16;
            done_o_mulmat_soft         : out std_logic
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

    component bias_soft is 
        generic (
            instance_number : integer
        );

        port (
            data_in_bias_soft           : in bfloat16;    
            clk_bias_soft               : in std_logic;
    
            data_o_bias_soft            : out bfloat16
        );
    end component;


    signal aux_data_o_mux_soft : bfloat16;
    signal aux_connect_mux_soft : std_logic_vector(5 downto 0);

    signal aux_data_o_mulmat_soft : bfloat16;
    signal aux_done_o_mulmat_soft : std_logic;

    signal aux_data_o_acc    : bfloat16;
    
    
begin

    instancia_mux_soft : component mux_soft 
        generic map (
            instance_number => neuron_number
        )

        port map (
            data_in_mux_soft => data,
            addr_in_mux_soft => address,
            clk_mux_soft     => clk,
    
            data_o_mux_soft => aux_data_o_mux_soft,
            connection_o_mux_soft => aux_connect_mux_soft
        );


    instancia_mulmat : component mulmat_soft
        generic map (
            instance_number => neuron_number
        )

        port map(
            --input----------------
            data_in_mulmat_soft => aux_data_o_mux_soft,
            connection_in_mulmat_soft => aux_connect_mux_soft,
            clk_mulmat_soft => clk,

            --output---------------
            data_o_mulmat_soft => aux_data_o_mulmat_soft,
            done_o_mulmat_soft => aux_done_o_mulmat_soft
        );
    
    instancia_acummulator : component acummulator
        port map(
            --input----------------
            data_in_acc => aux_data_o_mulmat_soft,
            done_in_acc => aux_done_o_mulmat_soft,
            clk_acc => clk, 

            --output---------------
            data_o_acc => aux_data_o_acc
        );

    instancia_bias_soft: component bias_soft 
        generic map (
            instance_number => neuron_number
        )

        port map (
            --input----------------
            data_in_bias_soft=> aux_data_o_acc,
            clk_bias_soft=> clk,

            --output---------------
            data_o_bias_soft=> data_o
        );

end architecture;