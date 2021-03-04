library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library work;
  use work.WasmFpgaInterconnectPackage.all;

entity WasmFpgaInterconnect is
    port (
        Flash_Adr : in std_logic_vector(23 downto 0);
        Flash_Sel : in std_logic_vector(3 downto 0);
        Flash_DatIn : in std_logic_vector(31 downto 0);
        Flash_We : in std_logic;
        Flash_Stb : in std_logic;
        Flash_Cyc : in std_logic_vector(0 downto 0);
        Flash_DatOut : out std_logic_vector(31 downto 0);
        Flash_Ack : out std_logic;
        Loader_Adr : in std_logic_vector(23 downto 0);
        Loader_Sel : in std_logic_vector(3 downto 0);
        Loader_DatIn : in std_logic_vector(31 downto 0);
        Loader_We : in std_logic;
        Loader_Stb : in std_logic;
        Loader_Cyc : in std_logic_vector(0 downto 0);
        Loader_DatOut : out std_logic_vector(31 downto 0);
        Loader_Ack : out std_logic;
        Bus_Adr : in std_logic_vector(23 downto 0);
        Bus_Sel : in std_logic_vector(3 downto 0);
        Bus_DatIn : in std_logic_vector(31 downto 0);
        Bus_We : in std_logic;
        Bus_Stb : in std_logic;
        Bus_Cyc : in std_logic_vector(0 downto 0);
        Bus_DatOut : out std_logic_vector(31 downto 0);
        Bus_Ack : out std_logic;
        Memory_Adr : out std_logic_vector(23 downto 0);
        Memory_Sel : out std_logic_vector(3 downto 0);
        Memory_DatIn: in std_logic_vector(31 downto 0);
        Memory_We : out std_logic;
        Memory_Stb : out std_logic;
        Memory_Cyc : out std_logic_vector(0 downto 0);
        Memory_DatOut : out std_logic_vector(31 downto 0);
        Memory_Ack : in std_logic
    );
end entity;

architecture WasmFpgaInterconnectArchitecture of WasmFpgaInterconnect is

begin

  Memory_Adr <= Flash_Adr when Flash_Cyc = "1" else
                Loader_Adr when Loader_Cyc = "1" else
                Bus_Adr when Bus_Cyc = "1" else
                (others => '0');

  Memory_Sel <= Flash_Sel when Flash_Cyc = "1" else
                Loader_Sel when Loader_Cyc = "1" else
                Bus_Sel when Bus_Cyc = "1" else
                (others => '0');

  Memory_DatOut <= Flash_DatIn when Flash_Cyc = "1" else
                   Loader_DatIn when Loader_Cyc = "1" else
                   Bus_DatIn when Bus_Cyc = "1" else
                   (others => '0');

  Memory_We <= Flash_We when Flash_Cyc = "1" else
               Loader_We when Loader_Cyc = "1" else
               Bus_We when Bus_Cyc = "1" else
               '0';

  Memory_Stb <= Flash_Stb when Flash_Cyc = "1" else
                Loader_Stb when Loader_Cyc = "1" else
                Bus_Stb when Bus_Cyc = "1" else
                '0';

  Memory_Cyc <= Flash_Cyc when Flash_Cyc = "1" else
                Loader_Cyc when Loader_Cyc = "1" else
                Bus_Cyc when Bus_Cyc = "1" else
                (others => '0');

  Flash_DatOut <= Memory_DatIn when Flash_Cyc = "1" else (others => '0');
  Flash_Ack <= Memory_Ack when Flash_Cyc = "1" else '0';

  Loader_DatOut <= Memory_DatIn when Loader_Cyc = "1" else (others => '0');
  Loader_Ack <= Memory_Ack when Loader_Cyc = "1" else '0';

  Bus_DatOut <= Memory_DatIn when Bus_Cyc = "1" else (others => '0');
  Bus_Ack <= Memory_Ack when Bus_Cyc = "1" else '0';

end;
