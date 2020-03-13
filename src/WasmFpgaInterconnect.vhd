library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library work;
  use work.WasmFpgaInterconnectPackage.all;

entity WasmFpgaInterconnect is
    port ( 
        Loaded : in std_logic;
        Loader_Adr : in std_logic_vector(23 downto 0);
        Loader_Sel : in std_logic_vector(3 downto 0);
        Loader_DatIn : in std_logic_vector(31 downto 0);
        Loader_We : in std_logic;
        Loader_Stb : in std_logic;
        Loader_Cyc : in std_logic_vector(0 downto 0);
        Loader_DatOut : out std_logic_vector(31 downto 0);
        Loader_Ack : out std_logic;
        Adr : in std_logic_vector(23 downto 0);
        Sel : in std_logic_vector(3 downto 0);
        DatIn : in std_logic_vector(31 downto 0); 
        We : in std_logic;
        Stb : in std_logic;
        Cyc : in std_logic_vector(0 downto 0);
        DatOut : out std_logic_vector(31 downto 0);
        Ack : out std_logic;
        Memory_Adr : out std_logic_vector(23 downto 0);
        Memory_Sel : out std_logic_vector(3 downto 0);
        Memory_DatIn: in std_logic_vector(31 downto 0);
        Memory_We : out std_logic;
        Memory_Stb : out std_logic;
        Memory_Cyc : out std_logic_vector(0 downto 0);
        Memory_DatOut : out std_logic_vector(31 downto 0);
        Memory_Ack : in std_logic
    );
end entity WasmFpgaInterconnect;

architecture WasmFpgaInterconnectArchitecture of WasmFpgaInterconnect is

begin

  Memory_Adr <= Loader_Adr when Loaded = '0' else Adr;
  Memory_Sel <= Loader_Sel when Loaded = '0' else Sel;
  Memory_DatOut <= Loader_DatIn when Loaded = '0' else DatIn;
  Memory_We <= Loader_We when Loaded = '0' else We;
  Memory_Stb <= Loader_Stb when Loaded = '0' else Stb;
  Memory_Cyc <= Loader_Cyc when Loaded = '0' else Cyc;

  Loader_DatOut <= Memory_DatIn when Loaded = '0' else (others => '0');
  Loader_Ack <= Memory_Ack when Loaded = '0' else '0';

  DatOut <= Memory_DatIn when Loaded = '1' else (others => '0');
  Ack <= Memory_Ack when Loaded = '1' else '0';

end;
