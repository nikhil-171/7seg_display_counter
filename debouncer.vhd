
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
	Port ( button : in STD_LOGIC;
       	clock : in STD_LOGIC;
       	debounce : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
signal counter : std_logic_vector(25 downto 0):= (others => '0');
signal shift_register: std_logic_vector(1 downto 0);


begin
process(clock)
begin
 if (rising_edge(clock)) then
   shift_register(0) <=  button;
   shift_register(1)  <= shift_register(0);
 
 
	if (button= '1') then
    	counter <= std_logic_vector(unsigned(counter) + 1);
 
	else
    	counter <= (others => '0');
	end if;
 
	if (unsigned(counter) = 2500000 OR unsigned(counter) > 2500000) then
       	debounce <= '1';
	elsif (unsigned(counter) = 0) then
      	debounce <= '0';
	end if;
end if;

end process;



end Behavioral;