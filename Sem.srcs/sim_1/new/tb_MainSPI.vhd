library ieee;
use ieee.std_logic_1164.all;

entity tb_MainSPI is
end tb_MainSPI;

architecture tb of tb_MainSPI is

    component MainSPI
        port (clk : in std_logic;
              sw  : in std_logic_vector (3 downto 0));
    end component;

    signal clk : std_logic := '0';
    signal sw  : std_logic_vector (3 downto 0);
    
begin

    dut : MainSPI
    port map (clk => clk,
              sw  => sw);

    stimuli : process
    
    begin
        -- EDIT Adapt initialization as needed
        clk <= '0';
        sw <= "1101";
        
        -- EDIT Add stimuli here
        for i in 0 to 100 loop   
        clk <= not clk;
        wait for 10 ns;
        end loop;   
        
        wait;
    end process;

end tb;