# Professionalització i Pressió Turística d'Airbnb a Barcelona

Aquest repositori conté el codi font, el tractament de dades i el marc teòric de la recerca sobre l'estructura de l'oferta d'allotjaments turístics a la ciutat de Barcelona, utilitzant les dades oficials extretes d'Inside Airbnb (desembre 2025).

## 1. Justificació del Projecte i Marc Teòric
El debat sobre l'impacte de les plataformes de lloguer de curta durada en el teixit urbà de Barcelona s'ha centrat sovint en conjectures. Aquest projecte neix de la necessitat de quantificar amb rigor científic dues dinàmiques crítiques: fins a quin punt l'oferta està controlada per estructures empresarials (professionalització) i com es distribueix realment aquest impacte en els diferents districtes de la ciutat.

L'anàlisi de les dades reals demostra de manera objectiva que el model original de l'"economia col·laborativa" (particulars que lloguen una habitació o el seu propi pis de forma esporàdica) és residual a Barcelona. El mercat està dominat per una estructura altament professionalitzada, fet que justifica plenament la implementació de polítiques públiques de control territorial diferenciades per districtes.

## 2. Hipòtesis d'Investigació
Per guiar l'anàlisi de dades i les visualitzacions interactives, es formulen tres hipòtesis de treball:

* **Hipòtesi 1 (Professionalització):** Més de la meitat de l'oferta total d'allotjaments a Airbnb Barcelona està gestionada per operadors professionals (Multi-hosts amb 5 o més pisos), desmitificant el concepte d'economia col·laborativa tradicional.
* **Hipòtesi 2 (Impacte Territorial):** La pressió turística no és homogènia; es concentra de manera crítica en tres districtes centrals i de transició (Eixample, Sants-Montjuïc i Sant Martí), superant clarament la mitjana de la resta de la ciutat.
* **Hipòtesi 3 (Relació activitat-capacitat):** Els allotjaments gestionats per perfils professionals presenten taxes de disponibilitat anual i ràtios de ressenyes mensuals significativament més elevades que els petits amfitrions, optimitzant l'explotació del sòl d'ús residencial per a finalitats turístiques.

## 3. Diccionari de Variables Utilitzades
El dataset original conté 85 variables, de les quals s'han seleccionat i enriquit les següents per al model final:

| Variable | Tipus | Descripció |
| :--- | :--- | :--- |
| `id` | Numèric | Identificador únic de l'allotjament a la plataforma. |
| `neighbourhood_group_cleansed` | Caràcter | Districte oficial de Barcelona on s'ubica el pis. |
| `accommodates` | Numèric | Capacitat màxima de persones que poden allotjar-se. |
| `availability_365` | Numèric | Nombre de dies a l'any que l'allotjament es troba disponible per ser reservat. |
| `reviews_per_month` | Numèric | Mitjana de ressenyes mensuals (indicador d'activitat i ocupació real). |
| `calculated_host_listings_count` | Numèric | Volum total de pisos que el mateix amfitrió té registrats a Barcelona. |
| `perfil_host` | Caràcter (Enriquit) | Classificació de l'amfitrió: Petit (1 pis), Multi-host (2-4 pisos) o Professional (5+ pisos). |
| `index_pressio` | Numèric (Enriquit) | Indicador combinat calculat: $(availability\_365 / 365) \times (reviews\_per\_month + 0.01)$. |