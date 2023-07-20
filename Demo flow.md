# Demo Flow

```mermaid
flowchart LR
A(Assets)
D(Department)
DO(Department Overview)
X(Executive Overview)
L(Location)
O(Geo Overview)
S(Site Mons)
U(Users)

O ---|Select Country|L
X ---|Total|A
X ---|by Dep|DO
DO ---|Asset|A

```
