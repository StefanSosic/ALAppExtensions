#if not CLEANSCHEMA24
table 4046 "Stg Data Exch Def CA"
{
    ReplicateData = false;
    Extensible = false;
    ObsoleteState = Removed;
    ObsoleteReason = 'This functionality will be replaced by invoking the actual upgrade from each of the apps';
    ObsoleteTag = '24.0';

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Type; Enum "Data Exchange Definition Type")
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
#endif