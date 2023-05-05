library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity digits is
    Port (
        clk : in  std_logic;
        clock_en : in std_logic ;
        reset : in  std_logic;
        en : in std_logic;
        ld : in STD_LOGIC;
        one_in: in std_logic_vector (3 downto 0);
        dir : in std_logic;
        updn : in STD_LOGIC;
        ones : out std_logic_vector(3 downto 0)
       
    );
end digits;


architecture Behavioral of digits is
 signal cnt_reg: std_logic_vector(3 downto 0);
    signal dir_reg: std_logic;
    signal val_reg: std_logic_vector(3 downto 0);
    
begin
process(clk)
begin
if (rising_edge(clk)) then
	if en = '1' then
     	if reset  = '1' then
        	cnt_reg <= (others => '0');
    	end if;
	end if;
    
	if en = '1' and clock_en = '1' then
 	if (updn = '1') then
    	dir_reg  <= dir;  
	end if;
    	if (ld = '1') then
     	val_reg <= one_in; 
    	end if;
 if (dir_reg = '1') then
 if (cnt_reg < val_reg) then
  cnt_reg <= std_logic_vector(unsigned(cnt_reg) + 1);
  else cnt_reg <= (others => '0');
  end if;
 end if;
 
	if (dir_reg = '0') then
	 if (cnt_reg > "0000") then
	  cnt_reg <= std_logic_vector(unsigned(cnt_reg) - 1);
	  else cnt_reg <= val_reg ;
		end if;
	end if;
 end if;
 end if;

 
 end process;
 ones <= std_logic_vector(cnt_reg);
   

end Behavioral;
    
--begin
    
--    process(clk, reset, dir) 
--    begin
--        if rising_edge(clk) then
--            if reset = '1' then
--               ones  <= "0000";
--            end if;
--                if dir= "1010" then
--                    if one_in = "1001" then
--                    ones <= "0000";
--                    else
--                    ones <= std_logic_vector(unsigned(one_in) + 1);
--                end if;
--                end if;
                
--                if dir= "1011" then
--                    if one_in = "1001" then
--                    ones <= "0000";
--                    else
--                    ones <= std_logic_vector(unsigned(one_in) - 1);
--                end if;
--            end if;
--           end if;                
--    end process;

         

--end Behavioral;
