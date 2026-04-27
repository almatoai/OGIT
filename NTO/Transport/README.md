# Transport NTO

Entities and relationships for tracking vessels, aircraft, ports, airports and flights.

## Entities
- **Vessel** - Watercraft identified by IMO number (source: Equasis, OFAC SDN)
- **Aircraft** - Aircraft identified by ICAO hex code (source: FAA Registry, UK CAA, OpenSky)
- **Port** - Seaports and terminals identified by UN/LOCODE
- **Airport** - Airports identified by ICAO code (source: OurAirports)
- **Flight** - Individual flight events from departure to arrival (source: OpenSky Network)

## Verbs
- registeredTo, operatedBy, flaggedBy, inspectedAt, departedFrom, arrivedAt, flownBy

## Cross-NTO Relations
- Vessel/Aircraft relate to Compliance:SanctionsEntry (sanctioned assets)
- Transport:Aircraft relates to MRO.Aviation:Aircraft (maintenance data linkage)
- Transport:Airport relates to MRO.Aviation:Airport (maintenance data linkage)
- Vessel/Aircraft registeredTo/operatedBy SGO Person/Organization

## Context
Part of the OSINT Security Data Extension for law enforcement and intelligence use cases.
