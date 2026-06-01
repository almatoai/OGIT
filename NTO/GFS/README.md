# GFS

## Overview

This is a graph system NTO governing the **Bardioc Graph File
System (GFS)** -- a platform-level filesystem in which files,
folders, symbolic links, sharing tokens, and file-type-to-app
mappings are first-class graph constructs. Bytes live in the
platform object store; metadata, permissions, and audit live
in the graph.

## Contents

| Folder | What it holds |
|---|---|
| `entities/` | Five vertex types: `File`, `Folder`, `Symlink`, `ShareLink`, `AppHandler`. Each derives from `ogit:Entity`; none are subclasses of an existing OGIT type. |
| `verbs/` | Two new edges: `refersTo` (Symlink to target), `sharedVia` (File or Folder to ShareLink). Containment (`ogit:contains`) and team membership (`ogit.Auth:isMemberOf`) are reused unchanged. |
| `attributes/` | Seventeen new properties covering MIME, content-pointers (via standard OGIT attributes), per-device restrictions, the ShareLink token, the AppHandler mapping fields, and soft-delete markers. |

## Permission model

Permissions are not modelled here. They reuse the platform's
existing scope, role-rule, and ACL-materialisation mechanisms.
The platform materialisation pipeline maintains two reserved
properties on every GFS vertex -- `_effectiveReaders` and
`_effectiveDevices` -- which the platform owns and which are
not part of the `ogit.GFS:` namespace.

## Related platform extensions

GFS depends on three constructs that live outside `NTO/GFS/`
and ship as separate platform-team contributions (coordinated
with the OGIT review):

- `ogit.Auth:Device` -- end-user device vertex carrying a
  `securityLevel` 0-100.
- `ogit.Auth:usesDevice` -- Account-to-Device, many-to-many.
- `ogit:hasVault` -- Person-to-DataScope anchor for Personal
  Vaults (location open: `SGO/sgo/verbs/` or `NTO/Auth/verbs/`).
- A Workspace marker (boolean attribute) on `ogit.Auth:Team`.

## Audit

GFS does not introduce an `AuditEvent` vertex. Audit is a
platform concern; GFS emits events through the existing
platform `AuditEventListenerRegistry`. A consolidated platform
audit concept is tracked separately.
