library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.CONFIG.ALL;
use work.mulmatmem.ALL;

entity neuron is 
    port (
        data    : in std_logic_vector(data_size - 1 downto 0);
        address : in std_logic_vector(address_size - 1 downto 0);  
        clk     : in std_logic;
        valid   : in std_logic;

        data_o  : out std_logic_vector(data_size - 1 downto 0);
        ready_o : out std_logic;
        clk_o   : out std_logic

    );
end neuron;

architecture comportamental of neuron is
    --declaring all internal components 

    component mulmat is
        port (
            data_in_mulmat        : in std_logic_vector(data_size - 1 downto 0);    
            addr_in_mulmat        : in std_logic_vector(address_size - 1 downto 0);
            clk_mulmat            : in std_logic;
            valid_in_mulmat       : in std_logic;
    
            data_out_mulmat       : out std_logic_vector(data_size - 1 downto 0);
            done_o_mulmat         : out std_logic;
            ready_o_mulmat        : out std_logic;
            clk_o_mulmat          : out std_logic
        );
    end component;

    component acummulator is 
        port (
            data_in_acc         : in std_logic_vector(data_size - 1 downto 0);    
            done_in_acc         : in std_logic;
            clk_acc             : in std_logic;
    
            data_o_acc          : out std_logic_vector(data_size - 1 downto 0);
            clk_o_acc           : out std_logic
        );
    end component;

    component bias is 
        port (
            data_in_bias            : in std_logic_vector(data_size - 1 downto 0);    
            clk_bias                : in std_logic;
    
            data_o_bias             : out std_logic_vector(data_size - 1 downto 0);
            clk_o_bias              : out std_logic
        );
    end component;

    component relu is 
        port (
            clk_relu       : in std_logic;
            data_in_relu   : in std_logic_vector(data_size - 1 downto 0);
            
            data_o_relu    : out std_logic_vector(data_size - 1 downto 0);
            clk_o_relu     : out std_logic
        );
    end component;

    signal aux_data_o_mulmat : std_logic_vector(data_size - 1 downto 0);
    signal aux_done_o_mulmat : std_logic;
    signal aux_clk_o_mulmat  : std_logic;

    signal aux_data_o_acc    : std_logic_vector(data_size - 1 downto 0);
    signal aux_clk_o_acc     : std_logic;
    
    signal aux_data_o_bias   : std_logic_vector(data_size - 1 downto 0);
    signal aux_clk_o_bias    : std_logic;

begin

    instancia_mulmat : component mulmat
        port map(
            --input----------------
            data_in_mulmat => data,
            addr_in_mulmat => address,
            clk_mulmat => clk,
            valid_in_mulmat => valid,

            --output---------------
            data_out_mulmat => aux_data_o_mulmat,
            done_o_mulmat => aux_done_o_mulmat,
            ready_o_mulmat => ready_o,
            clk_o_mulmat => aux_clk_o_mulmat
        );
    
    instancia_acummulator : component acummulator
        port map(
            --input----------------
            data_in_acc => aux_data_o_mulmat,
            done_in_acc => aux_done_o_mulmat,
            clk_acc => aux_clk_o_mulmat,

            --output---------------
            data_o_acc => aux_data_o_acc,
            clk_o_acc => aux_clk_o_acc
        );

    instancia_bias : component bias 
        port map (
            --input----------------
            data_in_bias => aux_data_o_acc,
            clk_bias => aux_clk_o_acc,

            --output---------------
            data_o_bias => aux_data_o_bias,
            clk_o_bias => aux_clk_o_bias
        );

    instancia_relu : component relu 
        port map (
            --input----------------
            data_in_relu => aux_data_o_bias,
            clk_relu => aux_clk_o_bias,

            --output---------------
            data_o_relu => data_o,
            clk_o_relu => clk_o
        );
end architecture;