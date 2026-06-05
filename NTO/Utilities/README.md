# Utilities NTO

## Overview

The `ogit/Utilities/` namespace provides a cross-domain umbrella for
utility-industry concepts (operators, control centres, schedules,
outages, operational limits, energy carriers, conversion units) plus
the first concrete sub-domain `Utilities/Electricity/` covering the
transmission and high-voltage distribution system end-to-end.

Total scope: **270 entities**, **919 attributes**, **102 locally
declared verbs** (plus 18 OGIT-core verbs reused via the `ogit:`
prefix) across 13 sub-namespaces.

## Sub-namespace map

| Sub-namespace | Entities | Theme |
|---|---:|---|
| `Utilities/` | 7 | Cross-domain umbrella (NetworkOperator, ControlCenter, Outage, OperationalLimit, Schedule, EnergyCarrier, ConversionUnit) |
| `Utilities/Emissions/` | 5 | Greenhouse-gas emissions, factors, carbon intensity, inventory, CEMS measurements |
| `Utilities/Electricity/` | 24 | CIM PowerSystemResource root, GeneratingUnit subtypes (Thermal / Nuclear / Hydro / Wind / Solar), EnergyStorage, EnergyConsumer (ConformLoad / NonConformLoad), market-frame grouping (ControlArea, BiddingZone, SynchronousArea, LFCArea, LFCBlock, MarketParticipant, Interconnector, TieFlow), reified-relation anchors (OwnershipShare, ControlAreaMembership, SynchronousAreaMembership, BiddingZoneMembership) |
| `Utilities/Electricity/Grid/` | 65 | CGMES EQ + TP equipment: Substation / VoltageLevel / Bay, ACLineSegment / DCLineSegment, PowerTransformer + PowerTransformerEnd + tap-changers, Switch family (Breaker / Disconnector / LoadBreakSwitch / GroundDisconnector / Jumper / Fuse), BusbarSection / ConnectivityNode / TopologicalNode / TopologicalIsland / Terminal, ShuntCompensator (Linear / Nonlinear) / SeriesCompensator / StaticVarCompensator, HVDC converters (ACDCConverter abstract + CsConverter / VsConverter + DC topology), EquivalentInjection / EquivalentBranch / EquivalentShunt + EnergySource, MutualCoupling, SynchronousMachine / AsynchronousMachine, BaseVoltage, GeographicalRegion / SubGeographicalRegion, ConformLoadGroup / NonConformLoadGroup + ConformLoadSchedule, LoadArea / SubLoadArea, OperationalLimit family (OperationalLimitSet + OperationalLimitType + 5 typed limits), VoltageControlZone, Curve / CurveData / ReactiveCapabilityCurve, FaultIndicator / ProtectionEquipment |
| `Utilities/Electricity/Market/` | 14 | NC EB / NC CACM products: DayAheadSchedule / IntradaySchedule / BalancingSchedule, EnergyProduct, FlowGate, AllocatedTransmissionCapacity, ImbalanceSettlement, SettlementPeriod, CrossZonalCapacity, plus the Market vertex itself |
| `Utilities/Electricity/Legacy/` | 8 | UCTE-DEF record types (C / N / L / T / TT / R / E / DC) with `mappedTo` forward references into CGMES |
| `Utilities/Electricity/Diagram/` | 8 | CGMES DL + GL profiles: Diagram, DiagramObject + DiagramObjectPoint, DiagramStyle, ColorScheme, GeographicalLocation + CoordinateSystem + PositionPoint |
| `Utilities/Electricity/Operations/` | 24 | UCTE OH + NC SO / NC ER operational entities: OperationalState, Contingency / ContingencyElement / ContingencyList / ContingencyAnalysis, NetworkCodeViolation, SwitchingPlan + SwitchAction, PlannedOutage / ForcedOutage, WorkOrder, VoltageControlSchedule / ReactivePowerSchedule, SystemWideAlert, DefensePlan, BlackStartService, CongestionManagementAction, RestorationPlan |
| `Utilities/Electricity/Operations/StateEstimation/` | 11 | CGMES SV-profile anchors (SvVoltage / SvPowerFlow / SvShuntCompensatorSections / SvTapStep / SvInjection / SvStatus), Measurement family (MeasurementValue / AnalogValue / DiscreteValue / AccumulatorValue / StringValue), ValueAliasSet |
| `Utilities/Electricity/Operations/Reserves/` | 13 | NC EB FCR / aFRR / mFRR / RR reserve products: per-product Offering + Bid + Activation + Settlement classes, BalancingServiceProvider, ReserveUnit |
| `Utilities/Electricity/Telecontrol/` | 34 | IEC 60870-5-101 / 60870-5-104 ASDU types: monitor 1-21 (+ CP56Time2a 30-40), control 45-64, system 70 + 100-107, parameter 110-113, file 120-127, plus ProtocolEndpoint / RTU / IED |
| `Utilities/Electricity/Telecontrol/InterControlCenter/` | 24 | TASE.2 / IEC 60870-6 Conformance Blocks 1-9: BilateralTable, ConformanceBlock, DataSet / DataSetMember / DataSetTransferSet, IndicationPoint family (Single / Double / Discrete / Real / State / TaseProtection), TransferReport, IntegrityRequest, InformationMessage, DeviceTag, TaseProgram, EventLog, Account / AuthenticationRecord / Association, MmsObjectReference, ConditionVariable, StateEnumeration |
| `Utilities/Electricity/Dynamics/` | 31 | CGMES DY profile -- parametric modelling via `modelKind` enum + `parameterPayload` JSON: SynchronousMachineDynamics, ExcitationSystemDynamics, TurbineGovernorDynamics (Steam / Hydro / Gas / Wind), PowerSystemStabilizerDynamics, AsynchronousMachineDynamics, LoadDynamics (Static-ConstantPower / -ConstantImpedance / -ConstantCurrent / -Exponential / -Zip / -Composite), HvdcDynamics, FactsDynamics, WindGeneratorDynamics, SolarInverterDynamics, BatteryEnergyStorageDynamics, OverexcitationLimiterDynamics, UnderexcitationLimiterDynamics, VoltageCompensatorDynamics, MechanicalLoadDynamics, ProtectionRelayDynamics, plus DynamicModelTemplate / DynamicSimulationCase / StabilityModel / EmtModel / DynamicParameterSet |

## Standards coverage

| Standard | Coverage | Notes |
|---|---|---|
| **CIM / CGMES 2.4.15 EQ** | full class-level | includes ACDCConverter abstract + EnergySource |
| **CIM / CGMES 2.4.15 SSH** | attribute mapping to Timeseries channels | per-attribute mapping in the companion Reference document |
| **CIM / CGMES 2.4.15 TP / SV** | full | topology and state-variable anchors |
| **CIM / CGMES 2.4.15 DY** | parametric | `modelKind` enum + `parameterPayload` JSON; ~100 CIM DY classes -> ~30 NTO Dynamics classes |
| **CIM / CGMES 2.4.15 DL / GL** | full | diagram layout and geographical location |
| **CGMES 3.0 extensions** | partial | PetersenCoil, GroundingImpedance, per-phase models, BusNameMarker tracked as v2 follow-ups |
| **UCTE-DEF** | full record-type coverage | C, N, L, T, TT, R, E, DC; PSS/E variant records (S, C_T) handled via UcteComment + variantRecordKind enum |
| **IEC 60870-5-101 / 60870-5-104** | full standardised ASDU coverage | monitor 1-21 + CP56Time2a 30-40, control 45-64, system 70 + 100-107, parameter 110-113, file 120-127; reserved range 22-29 documented as DataPoint fallback |
| **TASE.2 / IEC 60870-6** | Conformance Blocks 1-9 | Block 2 covered both as `transferMode=periodic` on DataSetTransferSet and as separate IntegrityRequest class |
| **ENTSO-E EIC** | format + check-digit validation | 16-character regex + MOD-37/36 algorithm, see Reference Section 6a |
| **ENTSO-E NC SO / NC ER / NC EB / NC CACM** | full operational coverage | OperationalState, ContingencyAnalysis, FCR / aFRR / mFRR / RR products, market constructs |
| **ENTSO-E NC RfG** | partial | `rfgConnectionType` enum on GeneratingUnit; typed FaultRideThroughEnvelope / GeneratorConnectionRequirement deferred to v2 |
| **ENTSO-E NC HVDC** | partial | DC equipment hierarchy + Curve / ReactiveCapabilityCurve; FRT envelopes deferred to v2 |
| **UCTE / ENTSO-E Operation Handbook P1-P5** | full | all five policies mapped to operational classes |
| **IEC 61850** | referenced only | `iec61850Supported` boolean on IED; SCL coverage deferred to v2 |

## Architectural conventions

- **Materialised inheritance.** Every concrete subtype's TTL file
  contains the full union of its own and its parents' mandatory /
  optional / indexed / allowed lists -- OGIT does not propagate
  through `rdfs:subClassOf` at validate time. The TTL bundle in
  this PR was generated by a YAML-driven generator that walks the
  parent chain and emits the materialised lists; details in the
  companion Architecture Concept document.
- **Time-series convention.** No time-varying value is stored as a
  vertex attribute or JSON array. Every dynamic quantity rides on
  an attached `sgo:Timeseries` reached via `ogit:generates` from
  the anchor vertex. Channel-name convention:
  `<ConcreteClassName>.<attributeSemantic>.<unit>[.<channel>]`.
- **Reified relations.** Five relations get their own vertex class
  because they carry validity windows and provenance:
  `OwnershipShare`, `ControlAreaMembership`,
  `SynchronousAreaMembership`, `BiddingZoneMembership`,
  `SwitchAction`. CIM's own reified relations (`Terminal`,
  `PowerTransformerEnd`, `TieFlow`, `DiagramObject`) are kept as
  CIM defines them.
- **`ogit:parent ogit:Node` for every class.** The OGIT-normative
  graph-node declaration sits on every concrete and abstract
  class. The advisory domain parent uses `rdfs:subClassOf`.
- **Namespace scoping.** Cross-domain attributes (used by Emissions
  + Electricity + Operations) live in `ogit.Utilities:*`.
  Electricity-only attributes live in `ogit.Utilities.Electricity:*`.
  Sub-namespace-local attributes (Grid-specific, Telecontrol-
  specific, etc.) live in their respective sub-namespace prefix.
- **Closed value sets declared in TTL.** Every enum-valued and
  bool-valued attribute carries `ogit:validation-type "fixed"` plus
  `ogit:validation-parameter "v1,v2,..."` (for bool: literal
  `"true,false"`). This matches the existing OGIT convention used
  e.g. in `NTO/Knowledge/attributes/archived.ttl` (bool) and
  `NTO/Automation/attributes/rankingType.ttl` (enum) so the
  validator can enforce the allowed values at write time. Attributes
  whose description ends with `... etc.` or `... others` are open
  ranges and intentionally do not declare a fixed parameter
  (e.g. `limitUnit`, `measurementType`, `substance`).
- **Creator is Almato AG.** Every TTL file in this PR carries
  `dcterms:creator "Almato AG"` -- the organisation, not the
  individual contributor.

## Extension status

- This release covers the **Electricity** sub-domain end-to-end.
- The cross-domain `Utilities/` umbrella is designed to host
  future sub-domains: `Utilities/Gas/`, `Utilities/Heat/`,
  `Utilities/Water/`, `Utilities/Hydrogen/`. The
  cross-domain primitives (NetworkOperator, ControlCenter,
  Outage, Schedule, EnergyCarrier, ConversionUnit) are sized for
  that re-use without modification.

## Companion documents (concept phase)

Two reviewable concept documents live in the PR-companion
workspace at `~/Code/_connector-framework/Test Connector/_findings/`
(not shipped as part of this OGIT PR -- the OGIT PR ships only the
TTL bundle under `NTO/Utilities/`):

- `Architecture_Concept.md` -- design rationale, namespace plan,
  materialised-inheritance contract (Section 5.1c), reified-
  relation anchors with empirical examples (Section 8), time-
  series convention (Section 7a), plant-inventory mapping with
  the PowerPlant aggregation rule (Section 6), reviewer
  quorum (Section 11).
- `Ontology_Reference.md` -- auto-generated catalogue (per-class
  delta + inherited via parent chain, annotated), the standards-
  coverage matrix, the verb-collision check, the same-name-verb
  disambiguation table, all standards-mapping tables (CGMES DY
  bijection / SSH channel mapping / D.1-D.5 / EIC validation),
  and the TTL file inventory.

## Context

Bardioc (formerly HIRO) is the cross-utility data platform that
consumes this NTO. The Electricity sub-domain is the first
production target; gas / heat / water / hydrogen follow on the
same Utilities umbrella. The PR introduces ontology only -- no
upstream OGIT classes are modified (extend-only discipline).
