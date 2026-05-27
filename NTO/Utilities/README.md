# NTO/Utilities/

This namespace extends OGIT with utility-network domain coverage.
The first sub-domain is `Electricity/`; future sub-domains (Gas,
Heat, Hydrogen, Water) will attach as sibling branches without
disturbing the electrical model.

## Status

This PR opens the namespace skeleton. The concept proposal --
including the full entity catalogue, attribute scoping rules,
verb cardinalities, time-series modelling convention, TTL
generation strategy, and the standards-coverage mapping tables
for CGMES / UCTE-DEF / UCTE+ENTSO-E Operation Handbook / IEC
60870-5-101/104 / TASE.2 -- lives in the companion document
shared with reviewers:

- `OGIT_NTO_Utilities_Electricity_Concept_v1.docx`
  (Dropbox: `Claude Workspace / Bardioc Product Management /
  OGIT Extensions / Reviewable Deliverables`)
- Source markdown:
  `~/Code/_connector-framework/Test Connector/_findings/ogit_utilities_electricity_proposal.md`

The concept document has passed dialog-mode QS with both Claude
Opus 4.6 and Sonnet 4.6 on all four axes (4/4/4/4): consistency,
standards coverage, OGIT compliance, implementability.

## Sub-namespaces

| Sub-namespace | Entities | Theme |
|---|---:|---|
| `Utilities/` | 7 | Cross-domain base: NetworkOperator, ControlCenter, Outage, OperationalLimit, Schedule, EnergyCarrier, ConversionUnit |
| `Utilities/Emissions/` | 5 | Greenhouse-gas accounting (cross-domain) |
| `Utilities/Electricity/` | 24 | Electricity anchors: PSR hierarchy, GeneratingUnit + subtypes, PowerPlant, EnergyStorage, EnergyConsumer, ControlArea, BiddingZone, SynchronousArea, LFCArea, LFCBlock, Interconnector, TieFlow, MarketParticipant, reified relations |
| `Utilities/Electricity/Grid/` | 63 | CGMES EQ + TP: Substation, VoltageLevel, Bay, ACLineSegment, DCLineSegment, PowerTransformer, RatioTap / PhaseTap, Switch family, TopologicalNode / Island, ConnectivityNode, Terminal, ShuntCompensator (Linear / Nonlinear), SeriesCompensator, StaticVarCompensator, CsConverter, VsConverter, DCNode, DCTerminal, DCTopologicalIsland, DCConverterUnit, EquivalentInjection / Branch / Shunt, MutualCoupling, FaultIndicator, ProtectionEquipment, BaseVoltage, GeographicalRegion, SubGeographicalRegion, SynchronousMachine, AsynchronousMachine, TransformerStarImpedance, OperationalLimitSet + 5 typed limits, Curve / CurveData, ReactiveCapabilityCurve, BoundaryPoint, EquipmentContainer, Line, ConformLoadGroup / NonConformLoadGroup, LoadArea / SubLoadArea, ACDCConverter |
| `Utilities/Electricity/Operations/` | 24 | UCTE / ENTSO-E Operation Handbook regime |
| `Utilities/Electricity/Operations/StateEstimation/` | 11 | CGMES SV profile |
| `Utilities/Electricity/Operations/Reserves/` | 13 | FCR / aFRR / mFRR / RR per NC EB |
| `Utilities/Electricity/Telecontrol/` | 33 | IEC 60870-5-101 / 104 ASDU model |
| `Utilities/Electricity/Telecontrol/InterControlCenter/` | 23 | TASE.2 / IEC 60870-6 (ICCP) Block 1-9 |
| `Utilities/Electricity/Dynamics/` | 31 | CGMES DY profile (parameter sets) |
| `Utilities/Electricity/Diagram/` | 8 | CGMES DL + GL profiles |
| `Utilities/Electricity/Market/` | 14 | Day-ahead, intraday, balancing, cross-zonal |
| `Utilities/Electricity/Legacy/` | 8 | UCTE-DEF record reflections |

**Total: 265 entities, ~580 attributes, ~95 new verbs.**

## Seeded in this initial commit

This is the namespace-skeleton PR. The TTL phase will populate
all ~925 files via a generator script consuming the flat YAML
source-of-truth (`_ttl_gen/attributes.yaml`,
`_ttl_gen/entities.yaml`, `_ttl_gen/verbs.yaml`).

Seeded as worked examples in this PR (Section F of the concept
document):

- `Utilities/Electricity/Grid/entities/BusbarSection.ttl` --
  simple entity
- `Utilities/Electricity/entities/ThermalGeneratingUnit.ttl` --
  multi-level subtype with materialised inheritance
- `Utilities/Electricity/entities/OwnershipShare.ttl` --
  reified relation

Plus the attribute and verb TTLs these examples reference.

## Reviewer chain

- BOO (Chris Boos, architect)
- VOS (Viktor)
- BAR (Cy)
- OGIT-Maintainer (almatoai)

Sign-off on the concept document gates the full TTL phase.

## Conventions

See the concept document Sections 5 and 5.1a-g for the
authoritative conventions:

- Classes: CamelCase. Reuse `ogit:Entity` / `ogit:Node` as parent.
- Attributes: snake_case (deliberate; aligned with CIM tooling
  practice). One TTL per attribute at the lowest common ancestor
  namespace.
- Verbs: lowerCamelCase. Reuse existing OGIT verbs where the
  semantics match; range-narrowing TTL only when needed.
- Time-variant data: anchor-vertex pattern; all values via
  `sgo:Timeseries` attached with `generates`. No JSON / timestamp
  attributes on vertices.
- Edge attributes: never used. Reified classes
  (OwnershipShare, ControlAreaMembership, SynchronousAreaMembership,
  BiddingZoneMembership, SwitchAction) carry relation-attributes
  where needed.
- External-ontology mapping (OEO, Wikidata, OEP, GEM, BNetzA
  MaStR, IAEA PRIS): handled by Connector-Framework MappingRules
  per concept Section 9 -- NOT encoded as OWL equivalentClass in
  TTL.
