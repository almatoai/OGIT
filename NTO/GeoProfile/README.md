# 🗺️ OGIT GeoProfile

## Overview

**OGIT GeoProfile** provides a semantic model for representing **countries, regions, and their geopolitical, demographic, and cultural attributes** within the OGIT graph ontology.  
It is designed to capture standardized information about how nationsand  territories are defined, governed, and characterized..

This NTO focuses on *who and what a country is*, rather than *where assets are located*.  
For example, it models **ethnic composition, languages, political systems, and code standards**, not map geometries or sensor data.

---

## 📚 Structure

The GeoProfile NTO is organized into subdomains and entities:

| Namespace | Purpose |
|------------|----------|
| `ogit.GeoProfile` | Core entities and attributes describing countries and regions |
| `ogit.GeoProfile.Codes` | Standardized code systems (ISO, FIPS, GAUL, M49, GNS, GNIS) used for cross-dataset referencing |

---

## 🧭 Subdomain: GeoProfile.Codes

The **`ogit.GeoProfile.Codes`** namespace defines standardized identifiers for referencing countries, regions, and administrative units across data systems.

| Attribute | Standard | Description | Example |
|------------|-----------|--------------|----------|
| `ogit.GeoProfile.Codes:iso2` | ISO 3166-1 alpha-2 | Two-letter country code | `DE` |
| `ogit.GeoProfile.Codes:iso3` | ISO 3166-1 alpha-3 | Three-letter country code | `DEU` |
| `ogit.GeoProfile.Codes:fips` | FIPS 10-4 | U.S. government country code | `GM` |
| `ogit.GeoProfile.Codes:gaul` | FAO GAUL | FAO administrative boundary code | `82` |
| `ogit.GeoProfile.Codes:m49` | UN M49 | UN region or area numeric code | `276` |
| `ogit.GeoProfile.Codes:gns` | NGA GNS | GEOnet Names Server ID | `GNS_12345` |
| `ogit.GeoProfile.Codes:gnis` | USGS GNIS | Geographic Names Information System ID | `1234567` |

---