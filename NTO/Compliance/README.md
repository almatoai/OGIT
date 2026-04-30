# Compliance NTO

Entities and relationships for sanctions lists and regulatory compliance.

## Entities
- **SanctionsEntry** - A listing on a sanctions list (EU, UN, OFAC SDN, OFAC Non-SDN, UK)

## Verbs
- sanctionedUnder (Person/Organization is listed under a SanctionsEntry)

## Data Sources
- EU Consolidated Sanctions List (daily)
- UN Security Council Consolidated List (on change)
- OFAC SDN and Non-SDN Lists (multiple times/week)
- UK Sanctions List (on change)

## Cross-NTO Relations
- SanctionsEntry relates to SGO Person/Organization (sanctioned entities)
- SanctionsEntry relates to Transport:Vessel/Aircraft (sanctioned assets)
- SanctionsEntry relates to FinancialMarket:CryptoWallet (OFAC-listed crypto addresses)

## Note on Person/Organization
The verb sanctionedUnder needs to be added to the ogit:allowed blocks of
SGO Person.ttl and Organization.ttl in a separate update.

## Context
Part of the OSINT Security Data Extension for law enforcement and intelligence use cases.
