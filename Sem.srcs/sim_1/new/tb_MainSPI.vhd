library ieee;
use ieee.std_logic_1164.all;

entity tb_MainSPI is
end tb_MainSPI;

architecture tb of tb_MainSPI is

    component MainSPI
        port (clk : in std_logic;
              sw  : in std_logic_vector (3 downto 0);
              spi_bit : out std_logic
            );
              
    end component;

    signal clk : std_logic := '0';
    signal sw  : std_logic_vector (3 downto 0);
    signal spi_bit : std_logic;
begin

    dut : MainSPI
    port map (clk => clk,
              sw  => sw,
              spi_bit => spi_bit
              );

    stimuli : process
    
    begin
        -- EDIT Adapt initialization as needed
        clk <= '1';
        sw <= "1101";
        
        -- EDIT Add stimuli here
        for i in 0 to 50 loop  
        wait for 10 ns; 
        clk <= not clk; 
        end loop;   
        
        wait;
    end process;

end tb;