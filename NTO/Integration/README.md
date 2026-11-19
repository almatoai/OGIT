# Integration

## Overview

The records a connector framework keeps in the graph about the connectors it runs. A connector
is a program that reads a source system and sends its records into the graph; a blueprint is
the JSON document that declares how those records become vertices and edges.

* `Connector` -- one blueprint version deployed in one organization, carrying the blueprint.
* `WeavingRule` -- one rule of a blueprint that draws edges between vertices already in the
  graph, contained by its `Connector`.
* `ConnectorRunConfigSnapshot` -- the rules one run of a connector executes, frozen when the
  run opens. Internal bookkeeping of the connector framework.

All three are written by the connector framework. The application a connector belongs to, its
versions and their lifecycle are modelled in `ogit/Auth` (`Application`, `ApplicationVersion`),
not here.

Conventions common to every OGIT namespace (creator, fixed value sets, edge
targets, additive-only) are in the repository root README.
