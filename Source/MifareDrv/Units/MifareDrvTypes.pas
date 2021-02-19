unit MifareDrvTypes;

interface

type
  { TSAMSoftwareInfo }

  TSAMSoftwareInfo = record
    VendorID: Byte;
    RType: Byte;
    SubType: Byte;
    MajorVersion: Byte;
    MinorVersion: Byte;
    StorageSize: Byte;
    Protocol: Byte;
  end;

  { TSAMManufacturingData }

  TSAMManufacturingData = record
    UID: Int64;
    BatchNo: Int64;
    ProductionDay: Byte;
    ProductionMonth: Byte;
    ProductionYear: Byte;
    GlobalCryptoSettings: string;
  end;

  { TSAMVersion }

  TSAMVersion = record
    Data: string;
    HardwareInfo: TSAMSoftwareInfo;
    SoftwareInfo: TSAMSoftwareInfo;
    ManufacturingData: TSAMManufacturingData;
    Mode: Byte;
  end;


implementation

end.
