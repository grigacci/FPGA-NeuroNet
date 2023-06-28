library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.CONFIG.ALL;
use work.mulmat_soft_mem.ALL;
use work.mulmat_relu_mem.ALL;
use work.bus_multiplexer_pkg.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity neural_net is
    port (
        pixel : in bfloat16;
        addr  : in std_logic_vector(address_size - 1 downto 0);
        clk   : in std_logic;
        --valid_in : in std_logic;

        ready_input_o :out std_logic_vector(number_of_neurons - 1 downto 0);
        output : out std_logic_vector(3 downto 0);
        clk_o  : out std_logic
    );
end entity;

architecture behave of neural_net is

    component neuron_relu is 
        generic (
            neuron_number : integer
        );
    
        port (
            data    : in bfloat16;
            address : in std_logic_vector(address_size - 1 downto 0);  
            clk     : in std_logic;
            ready_in: in std_logic_vector(output_classes - 1 downto 0);
            --valid   : in std_logic;
            
            --addr_o  : out std_logic_vector(address_size - 1 downto 0);
            data_o  : out bfloat16;
            ready_o : out std_logic;
            clk_o_relu   : out std_logic
        );
    end component;

    component neuron_soft is
        generic (
            neuron_number: integer
        );
    
        port (
            data    : in bfloat16;
            address : in std_logic_vector(address_size - 1 downto 0);  
            clk     : in std_logic;
            --valid   : in std_logic;
    
            data_o  : out bfloat16;
            ready_o : out std_logic;
            clk_o_soft   : out std_logic
        );
    end component;

    component output_softmax is 
        port (
            data_in_output_softmax        : in bus_bfloat16(output_classes - 1 downto 0);    
            clk_output_softmax            : in std_logic;
    
            data_o_output_softmax          : out std_logic_vector(3 downto 0);
            clk_o_output_softmax           : out std_logic
        );
    end component;

    type relu_output is array (number_of_neurons - 1 downto 0) of bfloat16;
    type soft_output is array (output_classes - 1 downto 0) of bfloat16;

    signal aux_soft_output : soft_output;
    signal aux_relu_output : relu_output;
    signal aux_ready_relu  : std_logic_vector(number_of_neurons - 1 downto 0);
    signal aux_ready_soft  : std_logic_vector(output_classes - 1 downto 0);
    signal aux_clk_o_relu  : std_logic;
    signal aux_clk_o_soft  : std_logic;
    
    signal aux_addr_o_relu : std_logic_vector(address_size - 1 downto 0); 

begin

    gen_layer1 : for i in 0 to number_of_neurons - 1 generate
        instance_neuron_relu : component neuron_relu 
            generic map (
                neuron_number => i
            )
            port map (
                data => pixel,
                address => addr,
                clk => clk,
                ready_in => aux_ready_soft,
                --valid => valid_in,
                
                --addr_o => aux_addr_o_relu,
                data_o => aux_relu_output(i),
                ready_o => aux_ready_relu(i),
                clk_o_relu => aux_clk_o_relu
            );
        end generate;


    gen_layer2 : for i in 0 to output_classes - 1 generate
        instance_neuron_soft : component neuron_soft
            generic map (
                neuron_number => i
            )
            port map (
                data => aux_relu_output(i),
                address => aux_addr_o_relu,
                clk => clk,
                --valid => valid_in,
                
                
                data_o => aux_soft_output(i),
                ready_o => aux_ready_soft(i),
                clk_o_soft => open
            );
            end generate;
    

    instance_output : component output_softmax
            port map (
                data_in_output_softmax(0) => aux_soft_output(0),
                data_in_output_softmax(1) => aux_soft_output(1),
                data_in_output_softmax(2) => aux_soft_output(2),
                data_in_output_softmax(3) => aux_soft_output(3),
                data_in_output_softmax(4) => aux_soft_output(4),
                data_in_output_softmax(5) => aux_soft_output(5),
                data_in_output_softmax(6) => aux_soft_output(6),
                data_in_output_softmax(7) => aux_soft_output(7),
                data_in_output_softmax(8) => aux_soft_output(8),
                data_in_output_softmax(9) => aux_soft_output(9),

                clk_output_softmax => clk,
            
                data_o_output_softmax => output,          
                clk_o_output_softmax => clk_o  
            );            
           
    
 -- continuar
end architecture;