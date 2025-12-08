import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/image_viewer.dart';
class Scientist {
  final String name;
  final String birthYear;
  final String deathYear;
  final String contribution;
  final String imageAssetPath;
  final String region;
  final List<TimelineEvent> timeline;

  Scientist({
    required this.name,
    required this.birthYear,
    required this.deathYear,
    required this.contribution,
    required this.imageAssetPath,
    required this.region,
    required this.timeline,
  });
}

class TimelineEvent {
  final String year;
  final String event;

  TimelineEvent({required this.year, required this.event});
}

class ScientistsTimelinePage extends StatefulWidget {


  ScientistsTimelinePage({Key? key}) : super(key: key);

  @override
  State<ScientistsTimelinePage> createState() => _ScientistsTimelinePageState();
}

class _ScientistsTimelinePageState extends State<ScientistsTimelinePage> {
  final List<Scientist> scientists = [
    Scientist(
      name: "Isaac Newton",
      birthYear: "1643",
      deathYear: "1727",
      contribution: "Laws of motion, calculus, gravitation.",
      imageAssetPath: "assets/images/scientists/newton.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1643", event: "Born in Woolsthorpe, England."),
        TimelineEvent(year: "1661", event: "Enrolled at Trinity College, Cambridge."),
        TimelineEvent(year: "1667", event: "Developed calculus, studied optics during the plague.(1965-1967)"),
        TimelineEvent(year: "1668", event: "Built his first reflecting telescope."),
        TimelineEvent(year: "1669", event: "Appointed Lucasian Professor of Mathematics."),
        TimelineEvent(year: "1672", event: "Presented his experiments on light and color to the Royal Society."),
        TimelineEvent(year: "1687", event: "Published Philosophiæ Naturalis Principia Mathematica."),
        TimelineEvent(year: "1696", event: "Became Warden of the Mint."),
        TimelineEvent(year: "1703", event: "Elected President of the Royal Society."),
        TimelineEvent(year: "1727", event: "Died in London."),
      ],
    ),
    Scientist(
      name: "Marie Curie",
      birthYear: "1867",
      deathYear: "1934",
      contribution: "Pioneer of radioactivity, Nobel laureate in Physics and Chemistry.",
      imageAssetPath: "assets/images/scientists/curie.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1867", event: "Born in Warsaw, Poland."),
        TimelineEvent(year: "1891", event: "Moved to Paris, enrolled at the Sorbonne."),
        TimelineEvent(year: "1894", event: "Met Pierre Curie."),
        TimelineEvent(year: "1898", event: "Discovered polonium and radium."),
        TimelineEvent(year: "1903", event: "Awarded Nobel Prize in Physics."),
        TimelineEvent(year: "1906", event: "Became first female professor at the Sorbonne."),
        TimelineEvent(year: "1911", event: "Awarded Nobel Prize in Chemistry."),
        TimelineEvent(year: "1914", event: "Established the Radium Institute in Paris."),
        TimelineEvent(year: "1934", event: "Died from aplastic anemia."),
      ],
    ),
    Scientist(
      name: "Albert Einstein",
      birthYear: "1879",
      deathYear: "1955",
      contribution: "Theory of relativity, quantum physics.",
      imageAssetPath: "assets/images/scientists/einstein.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1879", event: "Born in Ulm, Germany."),
        TimelineEvent(year: "1900", event: "Graduated from ETH Zurich."),
        TimelineEvent(year: "1905", event: "Published the Annus Mirabilis papers (special relativity, photoelectric effect)."),
        TimelineEvent(year: "1915", event: "Introduced General Theory of Relativity."),
        TimelineEvent(year: "1921", event: "Won Nobel Prize in Physics."),
        TimelineEvent(year: "1933", event: "Emigrated to the USA due to Nazi policies."),
        TimelineEvent(year: "1939", event: "Warned Roosevelt about atomic bomb potential."),
        TimelineEvent(year: "1955", event: "Died in Princeton, USA."),
      ],
    ),
    Scientist(
      name: "Charles Darwin",
      birthYear: "1809",
      deathYear: "1882",
      contribution: "Theory of evolution by natural selection.",
      imageAssetPath: "assets/images/scientists/darwin.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1809", event: "Born in Shrewsbury, England."),
        TimelineEvent(year: "1831", event: "Embarked on HMS Beagle voyage."),
        TimelineEvent(year: "1836", event: "Returned from Beagle, began scientific studies."),
        TimelineEvent(year: "1859", event: "Published On the Origin of Species."),
        TimelineEvent(year: "1868", event: "Published The Variation of Animals and Plants under Domestication."),
        TimelineEvent(year: "1871", event: "Published The Descent of Man."),
        TimelineEvent(year: "1882", event: "Died in Down House, England."),
      ],
    ),
    Scientist(
      name: "Nikola Tesla",
      birthYear: "1856",
      deathYear: "1943",
      contribution: "AC electricity, radio, wireless technology.",
      imageAssetPath: "assets/images/scientists/tesla.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1856", event: "Born in Smiljan, Austrian Empire (now Croatia)."),
        TimelineEvent(year: "1884", event: "Emigrated to the USA."),
        TimelineEvent(year: "1887", event: "Developed induction motor and AC power system."),
        TimelineEvent(year: "1891", event: "Invented Tesla coil."),
        TimelineEvent(year: "1899", event: "Conducted high-voltage experiments in Colorado Springs."),
        TimelineEvent(year: "1901", event: "Began building Wardenclyffe Tower."),
        TimelineEvent(year: "1917", event: "Wardenclyffe Tower demolished."),
        TimelineEvent(year: "1943", event: "Died in New York City."),
      ],
    ),
    Scientist(
      name: "Galileo Galilei",
      birthYear: "1564",
      deathYear: "1642",
      contribution: "Modern physics, astronomy, telescope improvements.",
      imageAssetPath: "assets/images/scientists/galileo.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1564", event: "Born in Pisa, Italy."),
        TimelineEvent(year: "1589", event: "Became professor at University of Pisa."),
        TimelineEvent(year: "1609", event: "Built and improved telescopes."),
        TimelineEvent(year: "1610", event: "Discovered Jupiter's moons."),
        TimelineEvent(year: "1616", event: "Warned by Church about heliocentrism."),
        TimelineEvent(year: "1632", event: "Published Dialogue Concerning the Two Chief World Systems."),
        TimelineEvent(year: "1633", event: "Tried and placed under house arrest."),
        TimelineEvent(year: "1642", event: "Died near Florence."),
      ],
    ),
    Scientist(
      name: "Stephen Hawking",
      birthYear: "1942",
      deathYear: "2018",
      contribution: "Black holes, quantum gravity, cosmology.",
      imageAssetPath: "assets/images/scientists/hawking.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1942", event: "Born in Oxford, England."),
        TimelineEvent(year: "1963", event: "Diagnosed with ALS at age 21."),
        TimelineEvent(year: "1965", event: "Completed Ph.D. at Cambridge University."),
        TimelineEvent(year: "1970", event: "Theorized black hole radiation (Hawking radiation)."),
        TimelineEvent(year: "1979", event: "Became Lucasian Professor of Mathematics at Cambridge."),
        TimelineEvent(year: "1988", event: "Published A Brief History of Time."),
        TimelineEvent(year: "2009", event: "Retired from Cambridge."),
        TimelineEvent(year: "2018", event: "Died in Cambridge, England."),
      ],
    ),
    Scientist(
      name: "Rosalind Franklin",
      birthYear: "1920",
      deathYear: "1958",
      contribution: "X-ray diffraction images of DNA, structure of viruses.",
      imageAssetPath: "assets/images/scientists/franklin.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1920", event: "Born in London, England."),
        TimelineEvent(year: "1941", event: "Graduated from Cambridge University."),
        TimelineEvent(year: "1947", event: "Conducted research on coal and carbon in Paris."),
        TimelineEvent(year: "1951", event: "Joined King's College London, began DNA studies."),
        TimelineEvent(year: "1952", event: "Captured Photo 51 of DNA."),
        TimelineEvent(year: "1953", event: "Contributions aided Watson & Crick’s DNA model."),
        TimelineEvent(year: "1958", event: "Died of ovarian cancer."),
      ],
    ),
    Scientist(
      name: "Richard Feynman",
      birthYear: "1918",
      deathYear: "1988",
      contribution: "Quantum electrodynamics, Feynman diagrams.",
      imageAssetPath: "assets/images/scientists/feynman.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1918", event: "Born in New York, USA."),
        TimelineEvent(year: "1939", event: "Graduated from MIT."),
        TimelineEvent(year: "1945", event: "Worked on Manhattan Project.(1942-1945)"),
        TimelineEvent(year: "1965", event: "Nobel Prize in Physics (QED)."),
        TimelineEvent(year: "1985", event: "Published Surely You’re Joking, Mr. Feynman!."),
        TimelineEvent(year: "1988", event: "Died in Los Angeles, USA."),
      ],
    ),
    Scientist(
      name: "Ada Lovelace",
      birthYear: "1815",
      deathYear: "1852",
      contribution: "First computer programmer.",
      imageAssetPath: "assets/images/scientists/lovelace.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1815", event: "Born in London, England."),
        TimelineEvent(year: "1833", event: "Met Charles Babbage."),
        TimelineEvent(year: "1842", event: "Translated Menabrea’s work on the Analytical Engine."),
        TimelineEvent(year: "1843", event: "Added extensive notes describing the first algorithm."),
        TimelineEvent(year: "1852", event: "Died of uterine cancer."),
      ],
    ),
    Scientist(
      name: "Alexander Fleming",
      birthYear: "1881",
      deathYear: "1955",
      contribution: "Discovered penicillin.",
      imageAssetPath: "assets/images/scientists/fleming.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1881", event: "Born in Scotland."),
        TimelineEvent(year: "1906", event: "Began medical career at St Mary's Hospital, London."),
        TimelineEvent(year: "1928", event: "Discovered penicillin."),
        TimelineEvent(year: "1945", event: "Nobel Prize in Physiology or Medicine."),
        TimelineEvent(year: "1955", event: "Died in London."),
      ],
    ),
    Scientist(
      name: "Katherine Johnson",
      birthYear: "1918",
      deathYear: "2020",
      contribution: "NASA mathematician, computed orbits for Mercury, Apollo.",
      imageAssetPath: "assets/images/scientists/johnson.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1918", event: "Born in West Virginia, USA."),
        TimelineEvent(year: "1937", event: "Graduated with highest honors from West Virginia State College."),
        TimelineEvent(year: "1953", event: "Joined NACA (later NASA)."),
        TimelineEvent(year: "1961", event: "Checked orbital calculations for Alan Shepard’s mission."),
        TimelineEvent(year: "1962", event: "Calculated John Glenn’s orbital mission trajectory."),
        TimelineEvent(year: "1969", event: "Worked for Apollo 11 moon landing."),
        TimelineEvent(year: "1986", event: "Retired from NASA."),
        TimelineEvent(year: "2015", event: "Received Presidential Medal of Freedom."),
        TimelineEvent(year: "2020", event: "Died at age 101."),
      ],
    ),
    Scientist(
      name: "Carl Linnaeus",
      birthYear: "1707",
      deathYear: "1778",
      contribution: "Classification of living things (binomial nomenclature).",
      imageAssetPath: "assets/images/scientists/linnaeus.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1707", event: "Born in Sweden."),
        TimelineEvent(year: "1732", event: "Expeditions documenting flora and fauna in Lapland."),
        TimelineEvent(year: "1735", event: "Published Systema Naturae."),
        TimelineEvent(year: "1742", event: "Appointed professor at Uppsala University."),
        TimelineEvent(year: "1758", event: "Defined modern Homo sapiens classification."),
        TimelineEvent(year: "1778", event: "Died in Uppsala."),
      ],
    ),
    Scientist(
      name: "Dmitri Mendeleev",
      birthYear: "1834",
      deathYear: "1907",
      contribution: "Created the Periodic Table of Elements.",
      imageAssetPath: "assets/images/scientists/mendeleev.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1834", event: "Born in Tobolsk, Russia."),
        TimelineEvent(year: "1855", event: "Graduated from Main Pedagogical Institute."),
        TimelineEvent(year: "1869", event: "Presented version 1 of the periodic table."),
        TimelineEvent(year: "1871", event: "Predicted properties of undiscovered elements (gallium, germanium)."),
        TimelineEvent(year: "1905", event: "Awarded Copley Medal."),
        TimelineEvent(year: "1907", event: "Died in St. Petersburg."),
      ],
    ),
    Scientist(
      name: "James Clerk Maxwell",
      birthYear: "1831",
      deathYear: "1879",
      contribution: "Electromagnetic field theory.",
      imageAssetPath: "assets/images/scientists/maxwell.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1831", event: "Born in Edinburgh, Scotland."),
        TimelineEvent(year: "1856", event: "Professor at Marischal College, Aberdeen."),
        TimelineEvent(year: "1864", event: "Developed Maxwell’s equations."),
        TimelineEvent(year: "1871", event: "First Cavendish Professor at Cambridge."),
        TimelineEvent(year: "1879", event: "Died in Cambridge."),
      ],
    ),
    Scientist(
      name: "Niels Bohr",
      birthYear: "1885",
      deathYear: "1962",
      contribution: "Atomic structure, quantum theory.",
      imageAssetPath: "assets/images/scientists/bohr.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1885", event: "Born in Copenhagen, Denmark."),
        TimelineEvent(year: "1911", event: "Ph.D. on electron theory of metals."),
        TimelineEvent(year: "1913", event: "Published Bohr model of the atom."),
        TimelineEvent(year: "1922", event: "Nobel Prize in Physics."),
        TimelineEvent(year: "1943", event: "Fled Nazi-occupied Denmark."),
        TimelineEvent(year: "1962", event: "Died in Copenhagen."),
      ],
    ),
    Scientist(
      name: "Louis Pasteur",
      birthYear: "1822",
      deathYear: "1895",
      contribution: "Microbiology, pasteurization, vaccines.",
      imageAssetPath: "assets/images/scientists/pasteur.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1822", event: "Born in Dole, France."),
        TimelineEvent(year: "1847", event: "Earned doctorate in sciences."),
        TimelineEvent(year: "1857", event: "Shows fermentation is biological."),
        TimelineEvent(year: "1862", event: "Debunked spontaneous generation."),
        TimelineEvent(year: "1885", event: "Developed rabies vaccine."),
        TimelineEvent(year: "1895", event: "Died in Marnes-la-Coquette."),
      ],
    ),
    Scientist(
      name: "Grace Hopper",
      birthYear: "1906",
      deathYear: "1992",
      contribution: "Pioneer of computer programming, COBOL.",
      imageAssetPath: "assets/images/scientists/hopper.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1906", event: "Born in New York City."),
        TimelineEvent(year: "1934", event: "Earned Ph.D. in mathematics from Yale."),
        TimelineEvent(year: "1944", event: "Joined Harvard, worked on Mark I computer."),
        TimelineEvent(year: "1947", event: "Reports 'debugging' with the first computer bug."),
        TimelineEvent(year: "1952", event: "Developed first compiler (A-0)."),
        TimelineEvent(year: "1959", event: "Helped develop COBOL."),
        TimelineEvent(year: "1986", event: "Retired from U.S. Navy as Rear Admiral."),
        TimelineEvent(year: "1992", event: "Died in Arlington, Virginia."),
      ],
    ),
    Scientist(
      name: "Barbara McClintock",
      birthYear: "1902",
      deathYear: "1992",
      contribution: "Discovery of genetic transposition ('jumping genes').",
      imageAssetPath: "assets/images/scientists/mcclintock.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1902", event: "Born in Hartford, Connecticut."),
        TimelineEvent(year: "1927", event: "Ph.D. in botany, Cornell."),
        TimelineEvent(year: "1944", event: "Elected to National Academy of Sciences."),
        TimelineEvent(year: "1950", event: "Published work on transposable elements in maize."),
        TimelineEvent(year: "1983", event: "Nobel Prize in Physiology or Medicine."),
        TimelineEvent(year: "1992", event: "Died in Huntington, New York."),
      ],
    ),
    Scientist(
      name: "Jagadish Chandra Bose",
      birthYear: "1858",
      deathYear: "1937",
      contribution: "Pioneer of radio, microwave optics, plant physiology.",
      imageAssetPath: "assets/images/scientists/bose.png",
      region: "Asia",
      timeline: [
        TimelineEvent(year: "1858", event: "Born in Mymensingh (now Bangladesh)."),
        TimelineEvent(year: "1885", event: "Lecturer at Presidency College, Calcutta."),
        TimelineEvent(year: "1895", event: "Demonstrated wireless radio transmission."),
        TimelineEvent(year: "1901", event: "Invented Crescograph to measure plant growth."),
        TimelineEvent(year: "1917", event: "Founded Bose Institute in Calcutta."),
        TimelineEvent(year: "1937", event: "Died in Giridih, Bengal."),
      ],
    ),
    Scientist(
      name: "Erwin Schrödinger",
      birthYear: "1887",
      deathYear: "1961",
      contribution: "Wave mechanics, quantum theory.",
      imageAssetPath: "assets/images/scientists/schrodinger.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1887", event: "Born in Vienna, Austria."),
        TimelineEvent(year: "1910", event: "Ph.D. from University of Vienna."),
        TimelineEvent(year: "1926", event: "Developed Schrödinger equation of quantum mechanics."),
        TimelineEvent(year: "1933", event: "Received Nobel Prize in Physics."),
        TimelineEvent(year: "1939", event: "Moved to Ireland, became Director at Institute for Advanced Studies."),
        TimelineEvent(year: "1961", event: "Died in Vienna."),
      ],
    ),
    Scientist(
      name: "Max Planck",
      birthYear: "1858",
      deathYear: "1947",
      contribution: "Father of quantum theory.",
      imageAssetPath: "assets/images/scientists/planck.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1858", event: "Born in Kiel, Germany."),
        TimelineEvent(year: "1879", event: "Ph.D. from University of Munich."),
        TimelineEvent(year: "1900", event: "Established quantum hypothesis (Planck's constant)."),
        TimelineEvent(year: "1918", event: "Awarded Nobel Prize in Physics."),
        TimelineEvent(year: "1945", event: "Helped found the Max Planck Society."),
        TimelineEvent(year: "1947", event: "Died in Göttingen, Germany."),
      ],
    ),
    Scientist(
      name: "Gregor Mendel",
      birthYear: "1822",
      deathYear: "1884",
      contribution: "Founder of modern genetics.",
      imageAssetPath: "assets/images/scientists/mendel.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1822", event: "Born in Heinzendorf, Austrian Empire (now Czech Republic)."),
        TimelineEvent(year: "1843", event: "Became monk at St. Thomas\' Abbey."),
        TimelineEvent(year: "1856", event: "Began experiments on pea plants."),
        TimelineEvent(year: "1866", event: "Published laws of inheritance."),
        TimelineEvent(year: "1884", event: "Died in Brünn (now Brno, Czech Republic)."),
      ],
    ),
    Scientist(
      name: "Michael Faraday",
      birthYear: "1791",
      deathYear: "1867",
      contribution: "Electromagnetic induction, electrochemistry.",
      imageAssetPath: "assets/images/scientists/faraday.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1791", event: "Born in Newington Butts, England."),
        TimelineEvent(year: "1812", event: "Became laboratory assistant to Humphry Davy."),
        TimelineEvent(year: "1821", event: "Discovered electromagnetic rotation."),
        TimelineEvent(year: "1831", event: "Discovered electromagnetic induction."),
        TimelineEvent(year: "1834", event: "Formulated Faraday's laws of electrolysis."),
        TimelineEvent(year: "1867", event: "Died in London."),
      ],
    ),
    Scientist(
      name: "Antoine Lavoisier",
      birthYear: "1743",
      deathYear: "1794",
      contribution: "Father of modern chemistry, law of conservation of mass.",
      imageAssetPath: "assets/images/scientists/lavoisier.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1743", event: "Born in Paris, France."),
        TimelineEvent(year: "1768", event: "Joined French Academy of Sciences."),
        TimelineEvent(year: "1774", event: "Discovered role of oxygen in combustion."),
        TimelineEvent(year: "1789", event: "Published Traité Élémentaire de Chimie."),
        TimelineEvent(year: "1794", event: "Executed in Paris."),
      ],
    ),
    Scientist(
      name: "Enrico Fermi",
      birthYear: "1901",
      deathYear: "1954",
      contribution: "Nuclear reactor, quantum statistics.",
      imageAssetPath: "assets/images/scientists/fermi.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1901", event: "Born in Rome, Italy."),
        TimelineEvent(year: "1922", event: "Earned Ph.D. from University of Pisa."),
        TimelineEvent(year: "1938", event: "Received Nobel Prize in Physics."),
        TimelineEvent(year: "1942", event: "Built first nuclear reactor in Chicago."),
        TimelineEvent(year: "1944", event: "Worked on Manhattan Project."),
        TimelineEvent(year: "1954", event: "Died in Chicago, USA."),
      ],
    ),
    Scientist(
      name: "J. J. Thomson",
      birthYear: "1856",
      deathYear: "1940",
      contribution: "Discovery of the electron.",
      imageAssetPath: "assets/images/scientists/thomson.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1856", event: "Born in Cheetham Hill, England."),
        TimelineEvent(year: "1880", event: "Earned MA from Cambridge."),
        TimelineEvent(year: "1897", event: "Discovered the electron and isotopes."),
        TimelineEvent(year: "1906", event: "Received Nobel Prize in Physics."),
        TimelineEvent(year: "1918", event: "Became Master of Trinity College, Cambridge."),
        TimelineEvent(year: "1940", event: "Died in Cambridge, England."),
      ],
    ),
    Scientist(
      name: "Heike Kamerlingh Onnes",
      birthYear: "1853",
      deathYear: "1926",
      contribution: "Discovered superconductivity.",
      imageAssetPath: "assets/images/scientists/onnes.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1853", event: "Born in Groningen, Netherlands."),
        TimelineEvent(year: "1879", event: "Ph.D. from University of Groningen."),
        TimelineEvent(year: "1908", event: "Liquefied helium for the first time."),
        TimelineEvent(year: "1911", event: "Discovered superconductivity."),
        TimelineEvent(year: "1913", event: "Nobel Prize in Physics."),
        TimelineEvent(year: "1926", event: "Died in Leiden, Netherlands."),
      ],
    ),
    Scientist(
      name: "Subrahmanyan Chandrasekhar",
      birthYear: "1910",
      deathYear: "1995",
      contribution: "Stellar structure, black holes.",
      imageAssetPath: "assets/images/scientists/chandrasekhar.png",
      region: "Asia",
      timeline: [
        TimelineEvent(year: "1910", event: "Born in Lahore, British India (now Pakistan)."),
        TimelineEvent(year: "1930", event: "Entered University of Cambridge."),
        TimelineEvent(year: "1931", event: "Formulated the Chandrasekhar limit."),
        TimelineEvent(year: "1935", event: "Moved to the USA and joined University of Chicago."),
        TimelineEvent(year: "1983", event: "Received Nobel Prize in Physics."),
        TimelineEvent(year: "1995", event: "Died in Chicago, USA."),
      ],
    ),
    Scientist(
      name: "Mary Anning",
      birthYear: "1799",
      deathYear: "1847",
      contribution: "Paleontologist - discovered Jurassic fossils.",
      imageAssetPath: "assets/images/scientists/anning.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1799", event: "Born in Lyme Regis, England."),
        TimelineEvent(year: "1811", event: "Discovered first complete Ichthyosaurus skeleton."),
        TimelineEvent(year: "1823", event: "Discovered first complete Plesiosaurus skeleton."),
        TimelineEvent(year: "1828", event: "Found first British Pterosaur."),
        TimelineEvent(year: "1847", event: "Died in Lyme Regis."),
      ],
    ),
    Scientist(
      name: "John Bardeen",
      birthYear: "1908",
      deathYear: "1991",
      contribution: "Co-inventor of the transistor, superconductor theory.",
      imageAssetPath: "assets/images/scientists/bardeen.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1908", event: "Born in Madison, Wisconsin, USA."),
        TimelineEvent(year: "1947", event: "Co-invented the transistor at Bell Labs."),
        TimelineEvent(year: "1956", event: "Nobel Prize in Physics (Transistor)."),
        TimelineEvent(year: "1957", event: "Published BCS theory of superconductivity."),
        TimelineEvent(year: "1972", event: "Nobel Prize in Physics (Superconductivity)."),
        TimelineEvent(year: "1991", event: "Died in Boston, USA."),
      ],
    ),
    Scientist(
      name: "Henrietta Swan Leavitt",
      birthYear: "1868",
      deathYear: "1921",
      contribution: "Discovered relation between luminosity and period of Cepheid stars.",
      imageAssetPath: "assets/images/scientists/leavitt.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1868", event: "Born in Lancaster, Massachusetts, USA."),
        TimelineEvent(year: "1892", event: "Graduated from Radcliffe College."),
        TimelineEvent(year: "1895", event: "Joined Harvard College Observatory."),
        TimelineEvent(year: "1908", event: "Published discovery of period-luminosity relation for Cepheids."),
        TimelineEvent(year: "1912", event: "Refined the period-luminosity relationship."),
        TimelineEvent(year: "1921", event: "Died in Cambridge, USA."),
      ],
    ),
    Scientist(
      name: "Irène Joliot-Curie",
      birthYear: "1897",
      deathYear: "1956",
      contribution: "Artificial radioactivity, Nobel laureate in Chemistry.",
      imageAssetPath: "assets/images/scientists/joliotcurie.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1897", event: "Born in Paris, France."),
        TimelineEvent(year: "1925", event: "Ph.D. in science."),
        TimelineEvent(year: "1926", event: "Married Frédéric Joliot."),
        TimelineEvent(year: "1934", event: "Synthesis of new radioactive elements."),
        TimelineEvent(year: "1935", event: "Nobel Prize in Chemistry."),
        TimelineEvent(year: "1956", event: "Died in Paris, France."),
      ],
    ),
    Scientist(
      name: "Blaise Pascal",
      birthYear: "1623",
      deathYear: "1662",
      contribution: "Probability theory, fluid mechanics, Pascal's triangle.",
      imageAssetPath: "assets/images/scientists/pascal.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1623", event: "Born in Clermont-Ferrand, France."),
        TimelineEvent(year: "1642", event: "Invented the Pascaline (early mechanical calculator)."),
        TimelineEvent(year: "1646", event: "Conducted experiments on fluids and pressure."),
        TimelineEvent(year: "1654", event: "Laid the foundation for probability theory."),
        TimelineEvent(year: "1662", event: "Died in Paris, France."),
      ],
    ),
    Scientist(
      name: "André-Marie Ampère",
      birthYear: "1775",
      deathYear: "1836",
      contribution: "Founder of electrodynamics.",
      imageAssetPath: "assets/images/scientists/ampere.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1775", event: "Born in Lyon, France."),
        TimelineEvent(year: "1802", event: "Professor of physics and chemistry."),
        TimelineEvent(year: "1820", event: "Formulated Ampère's Law of electromagnetism."),
        TimelineEvent(year: "1826", event: "Published 'Memoir on the Mathematical Theory of Electrodynamic Phenomena'."),
        TimelineEvent(year: "1836", event: "Died in Marseille, France."),
      ],
    ),
    Scientist(
      name: "Chien-Shiung Wu",
      birthYear: "1912",
      deathYear: "1997",
      contribution: "Experimental physicist, demonstrated non-conservation of parity.",
      imageAssetPath: "assets/images/scientists/wu.png",
      region: "Asia",
      timeline: [
        TimelineEvent(year: "1912", event: "Born in Liuhe, China."),
        TimelineEvent(year: "1940", event: "Ph.D. from University of California, Berkeley."),
        TimelineEvent(year: "1944", event: "Worked on Manhattan Project."),
        TimelineEvent(year: "1956", event: "Led the Wu experiment (parity violation in beta decay)."),
        TimelineEvent(year: "1975", event: "First female President of American Physical Society."),
        TimelineEvent(year: "1997", event: "Died in New York, USA."),
      ],
    ),
    Scientist(
      name: "Jane Goodall",
      birthYear: "1934",
      deathYear: "",
      contribution: "Primatologist, chimpanzee behavior expert.",
      imageAssetPath: "assets/images/scientists/goodall.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1934", event: "Born in London, England."),
        TimelineEvent(year: "1960", event: "Began study of chimpanzees in Gombe, Tanzania."),
        TimelineEvent(year: "1965", event: "Obtained Ph.D. in ethology, Cambridge University."),
        TimelineEvent(year: "1977", event: "Founded the Jane Goodall Institute."),
        TimelineEvent(year: "2002", event: "Named UN Messenger of Peace."),
      ],
    ),
    Scientist(
      name: "Willis Carrier",
      birthYear: "1876",
      deathYear: "1950",
      contribution: "Inventor of modern air conditioning.",
      imageAssetPath: "assets/images/scientists/carrier.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1876", event: "Born in Angola, New York, USA."),
        TimelineEvent(year: "1901", event: "Graduated from Cornell University."),
        TimelineEvent(year: "1902", event: "Developed first electrical air conditioning unit."),
        TimelineEvent(year: "1915", event: "Founded Carrier Engineering Corporation."),
        TimelineEvent(year: "1950", event: "Died in New York, USA."),
      ],
    ),
    Scientist(
      name: "Rachel Carson",
      birthYear: "1907",
      deathYear: "1964",
      contribution: "Marine biologist, founder of modern environmentalism.",
      imageAssetPath: "assets/images/scientists/carson.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1907", event: "Born in Springdale, Pennsylvania, USA."),
        TimelineEvent(year: "1932", event: "Earned master's in zoology, Johns Hopkins."),
        TimelineEvent(year: "1941", event: "Published Under the Sea-Wind."),
        TimelineEvent(year: "1962", event: "Published Silent Spring, warning of pesticide dangers."),
        TimelineEvent(year: "1964", event: "Died in Maryland, USA."),
      ],
    ),
    Scientist(
      name: "Alessandro Volta",
      birthYear: "1745",
      deathYear: "1827",
      contribution: "Inventor of the electric battery.",
      imageAssetPath: "assets/images/scientists/volta.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1745", event: "Born in Como, Italy."),
        TimelineEvent(year: "1775", event: "Invented the electrophorus."),
        TimelineEvent(year: "1800", event: "Invented the voltaic pile (first battery)."),
        TimelineEvent(year: "1810", event: "Appointed count by Napoleon."),
        TimelineEvent(year: "1827", event: "Died in Como, Italy."),
      ],
    ),
    Scientist(
      name: "Tim Berners-Lee",
      birthYear: "1955",
      deathYear: "",
      contribution: "Inventor of the World Wide Web.",
      imageAssetPath: "assets/images/scientists/bernerslee.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1955", event: "Born in London, England."),
        TimelineEvent(year: "1976", event: "Graduated from Oxford University."),
        TimelineEvent(year: "1989", event: "Proposed the World Wide Web at CERN."),
        TimelineEvent(year: "1990", event: "Developed first web server and browser."),
        TimelineEvent(year: "2004", event: "Knighted by Queen Elizabeth II."),
      ],
    ),
    Scientist(
      name: "Rachel Lloyd",
      birthYear: "1839",
      deathYear: "1900",
      contribution: "First American woman to earn a Ph.D. in chemistry.",
      imageAssetPath: "assets/images/scientists/lloyd.png",
      region: "North America",
      timeline: [
        TimelineEvent(year: "1839", event: "Born in Ohio, USA."),
        TimelineEvent(year: "1887", event: "Earned Ph.D. from University of Zurich."),
        TimelineEvent(year: "1888", event: "Joined University of Nebraska faculty."),
        TimelineEvent(year: "1900", event: "Died in Cairo, Illinois."),
      ],
    ),
    Scientist(
      name: "Oscar Minkowski",
      birthYear: "1858",
      deathYear: "1931",
      contribution: "Diabetes research, role of the pancreas.",
      imageAssetPath: "assets/images/scientists/minkowski.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1858", event: "Born in Aleksotas, Russia (now Lithuania)."),
        TimelineEvent(year: "1881", event: "Earned M.D. from University of Konigsberg."),
        TimelineEvent(year: "1889", event: "Demonstrated role of pancreas in diabetes."),
        TimelineEvent(year: "1892", event: "Joined University of Strasbourg."),
        TimelineEvent(year: "1931", event: "Died in Hannover, Germany."),
      ],
    ),
    Scientist(
      name: "John von Neumann",
      birthYear: "1903",
      deathYear: "1957",
      contribution: "Mathematician, computer architecture (von Neumann architecture).",
      imageAssetPath: "assets/images/scientists/vonneumann.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1903", event: "Born in Budapest, Hungary."),
        TimelineEvent(year: "1925", event: "Ph.D. from University of Budapest."),
        TimelineEvent(year: "1930", event: "Joined Institute for Advanced Study, Princeton."),
        TimelineEvent(year: "1945", event: "Conceptualized the von Neumann computer architecture."),
        TimelineEvent(year: "1957", event: "Died in Washington, D.C., USA."),
      ],
    ),
    Scientist(
      name: "Emmy Noether",
      birthYear: "1882",
      deathYear: "1935",
      contribution: "Noether's Theorem, major contributions to abstract algebra.",
      imageAssetPath: "assets/images/scientists/noether.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1882", event: "Born in Erlangen, Germany."),
        TimelineEvent(year: "1907", event: "Received Ph.D. from University of Erlangen."),
        TimelineEvent(year: "1918", event: "Published Noether’s Theorem (conservation laws)."),
        TimelineEvent(year: "1933", event: "Emigrated to USA, taught at Bryn Mawr."),
        TimelineEvent(year: "1935", event: "Died in Pennsylvania, USA."),
      ],
    ),
    Scientist(
      name: "Jan Baptist van Helmont",
      birthYear: "1580",
      deathYear: "1644",
      contribution: "Pioneer of gas chemistry, coined 'gas'.",
      imageAssetPath: "assets/images/scientists/vanhelmont.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1580", event: "Born in Brussels, Belgium."),
        TimelineEvent(year: "1618", event: "Discovered several gases, including carbon dioxide."),
        TimelineEvent(year: "1630", event: "Coined the word 'gas'."),
        TimelineEvent(year: "1644", event: "Died in Vilvoorde, Belgium."),
      ],
    ),
    Scientist(
      name: "Jacques Cousteau",
      birthYear: "1910",
      deathYear: "1997",
      contribution: "Oceanographer, co-inventor of the Aqua-Lung.",
      imageAssetPath: "assets/images/scientists/cousteau.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1910", event: "Born in Saint-André-de-Cubzac, France."),
        TimelineEvent(year: "1943", event: "Co-invented the Aqua-Lung (scuba)."),
        TimelineEvent(year: "1950", event: "Converted research ship Calypso."),
        TimelineEvent(year: "1956", event: "Published The Silent World."),
        TimelineEvent(year: "1997", event: "Died in Paris, France."),
      ],
    ),
    Scientist(
      name: "Lise Meitner",
      birthYear: "1878",
      deathYear: "1968",
      contribution: "Co-discovered nuclear fission.",
      imageAssetPath: "assets/images/scientists/meitner.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1878", event: "Born in Vienna, Austria."),
        TimelineEvent(year: "1906", event: "Earned Ph.D. from University of Vienna."),
        TimelineEvent(year: "1939", event: "Explained the physics of nuclear fission."),
        TimelineEvent(year: "1947", event: "Worked at Sweden's Royal Institute of Technology."),
        TimelineEvent(year: "1968", event: "Died in Cambridge, England."),
      ],
    ),
    Scientist(
      name: "Tu Youyou",
      birthYear: "1930",
      deathYear: "",
      contribution: "Discovered artemisinin for malaria treatment.",
      imageAssetPath: "assets/images/scientists/tu.png",
      region: "Asia",
      timeline: [
        TimelineEvent(year: "1930", event: "Born in Ningbo, China."),
        TimelineEvent(year: "1955", event: "Graduated from Peking University Medical School."),
        TimelineEvent(year: "1969", event: "Led project to find antimalarial drugs."),
        TimelineEvent(year: "1972", event: "Isolated artemisinin."),
        TimelineEvent(year: "2015", event: "Received Nobel Prize in Physiology or Medicine."),
      ],
    ),
    Scientist(
      name: "Otto Hahn",
      birthYear: "1879",
      deathYear: "1968",
      contribution: "Nuclear fission of uranium.",
      imageAssetPath: "assets/images/scientists/hahn.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1879", event: "Born in Frankfurt, Germany."),
        TimelineEvent(year: "1901", event: "Earned Ph.D. in chemistry."),
        TimelineEvent(year: "1938", event: "Discovered nuclear fission with Fritz Strassmann."),
        TimelineEvent(year: "1944", event: "Nobel Prize in Chemistry."),
        TimelineEvent(year: "1968", event: "Died in Göttingen, Germany."),
      ],
    ),
    Scientist(
      name: "Caroline Herschel",
      birthYear: "1750",
      deathYear: "1848",
      contribution: "First female astronomer, discovered comets.",
      imageAssetPath: "assets/images/scientists/herschel.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1750", event: "Born in Hanover, Germany."),
        TimelineEvent(year: "1772", event: "Moved to England to join brother William Herschel."),
        TimelineEvent(year: "1786", event: "Discovered first comet."),
        TimelineEvent(year: "1828", event: "Awarded Gold Medal of the Royal Astronomical Society."),
        TimelineEvent(year: "1848", event: "Died in Hanover, Germany."),
      ],
    ),
    Scientist(
      name: "Santiago Ramón y Cajal",
      birthYear: "1852",
      deathYear: "1934",
      contribution: "Founder of modern neuroscience.",
      imageAssetPath: "assets/images/scientists/cajal.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1852", event: "Born in Petilla de Aragón, Spain."),
        TimelineEvent(year: "1873", event: "Graduated in medicine."),
        TimelineEvent(year: "1891", event: "Published neuron theory."),
        TimelineEvent(year: "1906", event: "Nobel Prize in Physiology or Medicine."),
        TimelineEvent(year: "1934", event: "Died in Madrid, Spain."),
      ],
    ),
    Scientist(
      name: "Leonardo da Vinci",
      birthYear: "1452",
      deathYear: "1519",
      contribution: "Renaissance polymath: anatomy, engineering, invention, painting.",
      imageAssetPath: "assets/images/scientists/davinci.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1452", event: "Born in Vinci, Republic of Florence (Italy)."),
        TimelineEvent(year: "1472", event: "Joined Florentine painters' guild."),
        TimelineEvent(year: "1495", event: "Painted The Last Supper."),
        TimelineEvent(year: "1503", event: "Began work on Mona Lisa."),
        TimelineEvent(year: "1519", event: "Died in Amboise, France."),
      ],
    ),
    Scientist(
      name: "Hans Christian Ørsted",
      birthYear: "1777",
      deathYear: "1851",
      contribution: "Discovered electromagnetism.",
      imageAssetPath: "assets/images/scientists/oersted.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1777", event: "Born in Rudkøbing, Denmark."),
        TimelineEvent(year: "1806", event: "Professor at University of Copenhagen."),
        TimelineEvent(year: "1820", event: "Discovered that electric currents create magnetic fields."),
        TimelineEvent(year: "1825", event: "First to isolate aluminum."),
        TimelineEvent(year: "1851", event: "Died in Copenhagen, Denmark."),
      ],
    ),
    Scientist(
      name: "William Harvey",
      birthYear: "1578",
      deathYear: "1657",
      contribution: "Discovered blood circulation.",
      imageAssetPath: "assets/images/scientists/harvey.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1578", event: "Born in Folkestone, England."),
        TimelineEvent(year: "1602", event: "M.D. from University of Padua."),
        TimelineEvent(year: "1628", event: "Published work on blood circulation."),
        TimelineEvent(year: "1657", event: "Died in Roehampton, England."),
      ],
    ),
    Scientist(
      name: "Severo Ochoa",
      birthYear: "1905",
      deathYear: "1993",
      contribution: "Nucleic acid synthesis, Nobel laureate.",
      imageAssetPath: "assets/images/scientists/ochoa.png",
      region: "Europe",
      timeline: [
        TimelineEvent(year: "1905", event: "Born in Luarca, Spain."),
        TimelineEvent(year: "1929", event: "M.D. from University of Madrid."),
        TimelineEvent(year: "1955", event: "Isolated polynucleotide phosphorylase."),
        TimelineEvent(year: "1959", event: "Nobel Prize in Physiology or Medicine."),
        TimelineEvent(year: "1993", event: "Died in Madrid, Spain."),
      ],
    ),
  ];
  String selectedRegion = 'All';

  // Example: Map distinct accent colors to regions for dark mode differentiation
  final Map<String, Color> regionAccentColors = {
    'All': Colors.deepPurple,
    'Europe': Colors.blueAccent,
    'Asia': Colors.pinkAccent,
    'North America': Colors.greenAccent,
    'Other': Colors.orangeAccent,
  };

  // Derive region options from your data
  List<String> get regions {
    final regionSet = scientists.map((s) => s.region).toSet().toList()..sort();
    return ['All', ...regionSet];
  }

  // Filtering logic based on selected region
  List<Scientist> get filteredScientists {
    if (selectedRegion == 'All') return scientists;
    return scientists.where((sci) => sci.region == selectedRegion).toList();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final tabIconSize = deviceWidth * 0.10;
    final horizontalPadding = deviceWidth * 0.05;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final accentColor = regionAccentColors[selectedRegion] ?? Colors.deepPurple;

    return DefaultTabController(
      length: filteredScientists.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scientists Timeline', style: AppTextStyles.appBar(context)),
          backgroundColor: AppColors.background(context),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: accentColor),
        ),
        backgroundColor: isDark
            ? accentColor.withOpacity(0.09)
            : AppColors.background(context),
        body: Column(
          children: [
            // ---------- REGION FILTER CHIP BAR ----------
            SizedBox(
              height: 60,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: regions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, idx) {
                  final region = regions[idx];
                  final isSelected = region == selectedRegion;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                        colors: [
                          accentColor.withOpacity(0.9),
                          accentColor.withOpacity(0.5),
                        ],
                      )
                          : null,
                      color: isSelected
                          ? null
                          : isDark
                          ? Colors.grey.shade900
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(22),
                      border: isSelected
                          ? Border.all(color: accentColor, width: 2.2)
                          : null,
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: accentColor.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => setState(() => selectedRegion = region),
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        children: [
                          Icon(
                            _regionIcon(region),
                            color: isSelected
                                ? Colors.white
                                : accentColor.withOpacity(0.6),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            region,
                            style: AppTextStyles.subtitle(context).copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? Colors.white70 : Colors.black87),
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // ---------- TIMELINE CONTENT ----------
            Expanded(
              child: filteredScientists.isEmpty
                  ? Center(
                child: Text(
                  'No scientist data found.',
                  style: AppTextStyles.headline(context).copyWith(
                    color: AppColors.subtitleText(context),
                  ),
                ),
              )
                  : DefaultTabController(
                length: filteredScientists.length,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: filteredScientists.map((sci) {
                        return Tab(
                          text: sci.name.split(' ').first,
                          iconMargin: const EdgeInsets.only(bottom: 4),
                          icon: CircleAvatar(
                            backgroundColor: AppColors.background(context),
                            backgroundImage: AssetImage(sci.imageAssetPath),
                            radius: tabIconSize / 2,
                          ),
                        );
                      }).toList(),
                      labelColor: accentColor,
                      unselectedLabelColor: AppColors.subtitleText(context),
                      indicatorColor: accentColor,
                      indicatorWeight: 3.2,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: filteredScientists.map((sci) {
                          return SafeArea(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding, vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: ImageViewer(
                                      imagePath: sci.imageAssetPath,
                                      caption: sci.name,
                                      height: deviceWidth * 0.35,
                                      borderRadius: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    "${sci.name} (${sci.birthYear} - ${sci.deathYear})",
                                    style: AppTextStyles.headline(context).copyWith(
                                      fontSize: 22,
                                      color: accentColor,
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    width: 38,
                                    margin: const EdgeInsets.only(top: 5, bottom: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent(context),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  Text(
                                    sci.contribution,
                                    style: AppTextStyles.body(context).copyWith(
                                      fontSize: 16,
                                      color: AppColors.mainText(context),
                                    ),
                                  ),
                                  Divider(
                                    height: 32,
                                    color: AppColors.cardShadow(context),
                                    thickness: 1,
                                  ),
                                  Text(
                                    "Timeline",
                                    style: AppTextStyles.headline(context).copyWith(
                                      fontSize: 20,
                                      color: accentColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...sci.timeline.map((event) => ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor:
                                      accentColor.withOpacity(0.12),
                                      radius: 22,
                                      child: Text(
                                        event.year,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.subtitle(context).copyWith(
                                          fontSize: 12,
                                          color: accentColor,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      event.event,
                                      style: AppTextStyles.body(context).copyWith(
                                        fontSize: 15,
                                        color: AppColors.mainText(context),
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _regionIcon(String region) {
    switch (region) {
      case 'Europe':
        return Icons.account_balance;
      case 'Asia':
        return Icons.landscape;
      case 'North America':
        return Icons.emoji_nature;
      case 'Other':
        return Icons.public;
      case 'All':
        return Icons.all_inclusive;
      default:
        return Icons.public;
    }
  }
}