library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory_VHDL is
    Port (
        clkA       : in  STD_LOGIC;
        rstA       : in  STD_LOGIC;
        wr_enA     : in  STD_LOGIC;
        wr_addrA   : in  STD_LOGIC_VECTOR (9 downto 0); -- 10-bit for 1024 addresses
        wr_dataA   : in  STD_LOGIC_VECTOR (15 downto 0); -- 16-bit write data
        clkB       : in  STD_LOGIC;
        rstB       : in  STD_LOGIC;
        rd_enB     : in  STD_LOGIC;
        rd_addrB   : in  STD_LOGIC_VECTOR (9 downto 0); -- 10-bit for 1024 addresses
        rd_dataB   : out STD_LOGIC_VECTOR (15 downto 0); -- 16-bit read data
        rd_validB  : out STD_LOGIC -- Read Valid Signal
    );
end memory_VHDL;

architecture Behavioral of memory_VHDL is

    -- Memory Declaration: 1024 locations, each 16 bits wide
    type t_Memory is array (0 to 1023) of STD_LOGIC_VECTOR(15 downto 0);
    signal r_Mem : t_Memory := (others => (others => '0')); -- Initialize memory to zero

    -- Signal for read data and read valid
    signal r_rd_dataB : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal r_rd_validB : STD_LOGIC := '0';

begin

    -- Write Process: Handles writes to memory
    write_process : process(clkA, rstA)
    begin
        if (rstA = '1') then
            -- Reset memory content to zero (optional)
            r_Mem <= (others => (others => '0'));
        elsif rising_edge(clkA) then
            if (wr_enA = '1') then
                -- Write data to the specified address
                r_Mem(to_integer(unsigned(wr_addrA))) <= wr_dataA;
            end if;
        end if;
    end process;

    -- Read Process: Handles reads from memory
    read_process : process(clkB, rstB)
    begin
        if (rstB = '1') then
            -- Reset read signals
            r_rd_dataB <= (others => '0');
            r_rd_validB <= '0';
        elsif rising_edge(clkB) then
            if (rd_enB = '1') then
                -- Read data from the specified address
                r_rd_dataB <= r_Mem(to_integer(unsigned(rd_addrB)));
                r_rd_validB <= '1'; -- Indicate valid data
            else
                r_rd_validB <= '0'; -- Invalidate read signal
            end if;
        end if;
    end process;

    -- Output Assignments
    rd_dataB <= r_rd_dataB;
    rd_validB <= r_rd_validB;

end Behavioral;
