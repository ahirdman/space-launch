DROP TABLE IF EXISTS locationsTest;

-- Table Definition ---------------------------------------------- Locations --

CREATE TABLE locationsTest (
    id integer GENERATED BY DEFAULT AS IDENTITY UNIQUE,
    site_country text NOT NULL,
    site_location text,
    site_name_long text NOT NULL,
    site_coordinates text UNIQUE,
    site_launch_complex text,
    site_id text UNIQUE PRIMARY KEY
);

-- Indices ------------------------------------------------------- Locations --

CREATE UNIQUE INDEX locations_site_id_key ON locations(site_id text_ops);
CREATE UNIQUE INDEX locations_pkey ON locations(site_id text_ops);
CREATE UNIQUE INDEX locations_id_key ON locations(id int4_ops);
CREATE UNIQUE INDEX locations_coordinates_key ON locations(site_coordinates text_ops);

INSERT INTO "public"."locations"("id","site_name_long","site_country","site_location","site_coordinates","site_launch_complex","site_id")
VALUES
(1,E'Kennedy Space Center',E'USA',E'Florida',E'28.524167, -80.650833',NULL,E'KSC'),
(2,E'Cape Canaveral Space Force Station',E'USA',E'Florida',E'28.488889, -80.577778',NULL,E'CCSFS'),
(3,E'Vandenberg Space Force Base',E'USA',E'California',E'34.732778, -120.568056',NULL,E'VSFB'),
(4,E'Wallops Flight Facility',E'USA',E'Virginia',E'37.940194, -75.466389	\n',NULL,E'WFF'),
(5,E'Pacific Spaceport Complex – Alaska',E'USA',E'Alaska',E'57.435833, -152.337778',NULL,E'PSCA');

-- Table Definition ---------------------------------------------- Rockets --

DROP TABLE IF EXISTS rocketsTest;

CREATE TABLE rocketsTest (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rocket_name text UNIQUE,
    rocket_description text,
    rocket_manufacturer text,
    rocket_stages integer
);

-- Indices ------------------------------------------------------- Rockets --

CREATE UNIQUE INDEX rockets_pkey ON rockets(id int4_ops);
CREATE UNIQUE INDEX rockets_name_key ON rockets(rocket_name text_ops);

INSERT INTO "public"."rockets"("id","rocket_name","rocket_description","rocket_manufacturer","rocket_stages")
VALUES
(1,E'Falcon 9',E'Falcon 9 is a two-stage-to-orbit (TSTO) medium-lift launch vehicle (MLV) that is designed and manufactured by SpaceX. Unlike most rockets in service, which are expendable launch systems, Falcon 9 is partially reusable, with the first stage capable of re-entering the atmosphere and landing vertically after separating from the second stage. This feat was achieved for the first time on flight 20 in December 2015. Since then, SpaceX has successfully landed boosters over a hundred times,[16] with individual first stages flying as many as twelve times.[17]\n\nBoth the first and second stages are powered by SpaceX Merlin engines, using cryogenic liquid oxygen and rocket-grade kerosene (RP-1) as propellants.[18][19] The rocket evolved with versions v1.0 (2010–2013), v1.1 (2013–2016), v1.2 Full Thrust (2015–present), including the Block 5 Full Thrust variant, flying since May 2018.\n\nFalcon 9 can lift payloads of up to 22,800 kilograms (50,300 lb) to low Earth orbit (LEO), 8,300 kg (18,300 lb) to geostationary transfer orbit (GTO) when expended, and 5,500 kg (12,100 lb) to GTO when the first stage is recovered, in a cargo shroud offering 145 cubic meters of volume.[1][20][21] The heaviest GTO payloads flown have been Intelsat 35e with 6,761 kg (14,905 lb), and Telstar 19V with 7,075 kg (15,598 lb). The latter was launched into a lower-energy GTO achieving an apogee well below the geostationary altitude,[22] while the former was launched into an advantageous super-synchronous transfer orbit.[23] In late 2021, a Falcon 9 was used to launch the IXPE probe into equatorial orbit from KSC with a post-launch orbital plane change maneuver.[24]\n\nAs of January 2021, Falcon 9 has the most launches among all U.S. rockets currently in operation and is the only U.S. rocket fully certified for transporting humans to the International Space Station,[25][26][27] and the only commercial rocket to launch humans to orbit.[28] On 24 January 2021, Falcon 9 set a record for the most satellites launched by a single rocket carrying 143 satellites into orbit.[29]',E'SpaceX',2),
(2,E'Soyuz',E'The Soyuz (Russian: Союз, meaning "union", GRAU index 11A511) was a Soviet expendable carrier rocket designed in the 1960s by OKB-1 and manufactured by State Aviation Plant No. 1 in Kuybyshev, Soviet Union. It was commissioned to launch Soyuz spacecraft as part of the Soviet human spaceflight program, first with 8 uncrewed test flights, followed by the first 19 crewed launches.[1] The original Soyuz also propelled four test flights of the improved Soyuz 7K-T capsule between 1972 and 1974. In total it flew 30 successful missions over 10 years and suffered two failures.[1]\n\nThe Soyuz 11A511 type, a member of the R-7 family of rockets, first flew in 1966. Derived from the Voskhod 11A57 type, It was a two-stage rocket, with four liquid-fuelled strap-on boosters clustered around the first stage, with a Block I second stage. The first four test launches were all failures, but eventually it worked.[2] The new, uprated core stage and strap-ons became standard for all R-7 derived launch vehicles to replace the numerous older variants in use on the 8A92, 11A57, and 8K78M types. While the original Blok I stage as developed in 1960 used RD-107 engines, the Soyuz boosters instead had RD-110s, which were more powerful as necessitated by the heavier weight of the Soyuz craft and also had several design improvements to increase reliability and safety on crewed missions. The Molniya 8K78M booster also adopted the RD-110 during 1965, but Voskhod boosters continued using the older RD-107.[3]\n\nStarting in 1973, the original Soyuz rocket was gradually superseded by the Soyuz-U derivative type, which became the worlds most prolific launcher, flying hundreds of missions over 43 years until its retirement scheduled for 2016. Other direct variants were Soyuz-L for low Earth orbit tests of the LK lunar lander (3 flights) and Soyuz-M built for a quickly abandoned military spacecraft and used for reconnaissance satellites instead (8 flights).\n\nThe aborted Soyuz 18-1 launch in 1975 was the final crewed flight of the 11A511 and as it occurred shortly before the ASTP mission, the United States requested that the Soviets provide details about this failure. They stated that Soyuz 19 would be using the newer 11A5511U booster model (i.e. Soyuz-U) so that the Soyuz 18-1 malfunction had no bearing on it.\n\nSoyuz rockets were assembled horizontally in the MIK Building at the launch site. The rocket was then rolled out, and erected on the launch pad',E'OKB-1',2);

-- Table Definition ---------------------------------------------- Launches --

DROP TABLE IF EXISTS launchesTest;

CREATE TABLE launchesTest (
    id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    launch_date text,
    launch_date_set boolean,
    launch_window text,
    launch_site text REFERENCES locations(site_id) ON DELETE SET NULL ON UPDATE CASCADE,
    launch_mission text,
    launch_rocket text,
    launch_image_url text,
    launch_mission_description text
);

-- Indices ------------------------------------------------------- Launches --

CREATE UNIQUE INDEX launches_pkey ON launches(id int4_ops);

INSERT INTO "public"."launches"("id","launch_date","launch_date_set","launch_window","launch_site","launch_mission","launch_rocket","launch_image_url","launch_mission_description")
VALUES
(1,E'June 19, 2022',TRUE,NULL,E'KSC',E'Artemis I Wet Dress Rehearsal',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/artemis_i_on_pad_sunshot.jpg',E'Teams will conduct the wet dress rehearsal for NASA’s Space Launch System rocket and Orion spacecraft on the launch pad at the agency’s Kennedy Space Center in Florida in preparation for the Artemis I flight test. '),
(2,E'June 28, 2022',TRUE,NULL,E'KSC',E'NASA\'s SpaceX CRS-25 Cargo Resupply Mission to the International Space Station',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/iss066e125299.jpg',E'The 25th SpaceX cargo resupply services mission (SpaceX CRS-25) carrying scientific research and technology demonstrations to the International Space Station will launch from NASA’s Kennedy Space Center in Florida. Experiments aboard the Dragon capsule include studies of the immune system, wound healing, soil communities, and cell-free biomarkers, along with mapping the composition of Earth’s dust and testing an alternative to concrete.'),
(3,E'Under Review',TRUE,NULL,NULL,E'CAPSTONE - CubeSat Pathfinder Mission',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/capstone_moon_final_0.jpg',E'CAPSTONE will validate new navigation technologies and verify dynamics in Gateway’s planned orbit. It will launch aboard a Rocket Lab Electron rocket from New Zealand.'),
(4,E'July 12, 2022',TRUE,NULL,NULL,E'James Webb Space Telescope First Images',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/webbartistconception.jpg',E'NASA’s James Webb Space Telescope, a partnership with ESA (European Space Agency) and the Canadian Space Agency (CSA), will release its first full-color images and spectroscopic data this summer. After launching on Dec. 25, 2021, Webb has been going through a six-month period of preparation. The first images and data will, for the first time, demonstrate Webb at its full power, ready to begin its science mission and unfold the infrared universe.'),
(5,E'July 2022',TRUE,NULL,NULL,E'X-57 First Flight',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/x-57_image_08_view_01_0.png',E'The first flight of NASA\'s X-57, a small, experimental airplane powered by electricity. All-electric technology will make flying cleaner, quieter, and more sustainable. The flight will take place at NASA\'s Armstrong Flight Research Center in California.'),
(6,E'August 2022',TRUE,NULL,E'KSC',E'Artemis I',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/sls_block1_tps_afterburner_engmarkings_sm.jpg',E'Artemis I will be the first integrated test of NASA’s deep space exploration systems: the Orion spacecraft, Space Launch System (SLS) rocket and the ground systems at Kennedy Space Center in Cape Canaveral, Florida. The first in a series of increasingly complex missions, Artemis I will be an uncrewed flight test that will provide a foundation for human deep space exploration, and demonstrate our commitment and capability to extend human existence to the Moon and beyond. During this flight, the spacecraft will travel 280,000 miles from Earth, thousands of miles beyond the Moon over the course of about a three-week mission. Orion will stay in space longer than any ship for astronauts has done without docking to a space station and return home faster and hotter than ever before.'),
(7,E'September 20, 2022',TRUE,NULL,E'KSC',E'Psyche',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/pia24473-psyche-spacecraft-16.jpg',E'Set to launch from NASA\'s Kennedy Space Center in Florida, Psyche will travel across the solar system to an asteroid of the same name, which has unusually high metal content. Scientists hope understand why this is so, and to help answer fundamental questions about Earth’s own metal core and the formation of our solar system.'),
(8,E'Sept. 26 — Oct. 1, 2022',TRUE,NULL,NULL,E'Double Asteroid Redirection Test (DART) Asteroid Impact',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/lrc-20211203_dart-ne1517.png',E'Sometime during this window, the DART spacecraft will slam into the asteroid Dimorphos at roughly 4 miles per second, attempting to slightly change the asteroid’s motion in a way that can be accurately measured using ground-based telescopes. The world’s first full-scale mission to test technology for defending Earth against potential asteroid or comet hazards, DART was launched Nov. 24, 2021.'),
(9,E'Late 2022',TRUE,NULL,NULL,E'Quesst',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/quesst_0.jpg',E'The first flight of the Quesst quiet supersonic aircraft will take place out of Lockheed flight facilities in Palmdale, California. The Quesst mission has two goals: 1) design and build NASA\'s X-59 research aircraft with technology that reduces the loudness of a sonic boom to a gentle thump to people on the ground; and 2) fly the X-59 over select U.S. communities to gather data on human responses to the sound generated during supersonic flight and deliver that data set to U.S. and international regulators.'),
(10,E'November 1, 2022',TRUE,NULL,E'VSFB',E'JPSS-2',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/jpss-2.png',E'NASA and the National Oceanic and Atmospheric Administration will launch NOAA’s JPSS-2 weather and climate satellite mission with NASA’s Low-Earth Orbit Flight Test of an Inflatable Decelerator (LOFTID) demonstration from Vandenberg Space Force Base in California'),
(11,E'November 2022',TRUE,NULL,NULL,E'Surface Water and Ocean Topography',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/87_swot_artist_eos_800.jpeg',E'The Surface Water and Ocean Topography mission will help researchers determine how much water Earth’s oceans, lakes, and rivers contain. This will aid scientists in understanding the effects of climate change on freshwater bodies and the ocean’s ability to absorb excess heat and greenhouse gases like carbon dioxide.'),
(12,E'December 22, 2022',TRUE,NULL,NULL,E'Intuitive Machines Commercial Payload Lunar Services',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/nova-c_on_moon_w_logo.jpg',E'A suite of robotic NASA payloads will be sent to the lunar surface as part of a Commercial Lunar Payload Services delivery, in this case by Intuitive Machines of Houston. Landing will take place in the following weeks.'),
(13,E'Fourth Quarter 2022',TRUE,NULL,NULL,E'Astrobotic Commercial Lunar Payload Services',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/clps_astrobiotic_peregrine.jpg',E'A suite of robotic NASA payloads will be sent to the lunar surface as part of a Commercial Lunar Payload Services delivery, in this case by Astrobotic Technology of Pittsburgh. Landing will take place in the following weeks. '),
(14,E'2022',TRUE,NULL,NULL,E'Tropospheric Emissions Monitoring of Pollution (TEMPO)',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/tempo.png',E'NASA\'s first Earth Venture Instrument mission, TEMPO will measure the pollution over North America, from Mexico City to the Canadian oil sands, and from the Atlantic to the Pacific, hourly and at high spatial resolution. TEMPO will be the first space-based instrument to monitor air pollutants hourly across the North American continent during daytime.'),
(15,E'2023',TRUE,NULL,NULL,E'NISAR',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/37_nisar_over_earth_300dpi_v3_nc.jpg',E'·NISAR—NASA + Indian Space Research Organization + synthetic aperture radars—is a joint mission with the Indian Space Research Organization to track subtle changes in Earth’s surface, spot warning signs of imminent volcanic eruptions, help to monitor groundwater supplies, track the melt rate of ice sheets tied to sea level rise, and observe shifts in the distribution of vegetation around the world.'),
(16,E'January 2024',TRUE,NULL,NULL,E'Plankton, Aerosol Cloud Ocean Ecosystem (PACE)',NULL,E'https://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/svs_pace_beauty2_0.jpg',E'PACE will advance the assessment of ocean health by measuring the distribution of phytoplankton, tiny plants and algae that sustain the marine food web.');

-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html
-- Error: Database is uninitialized and superuser password is not specified.
--        You must specify POSTGRES_PASSWORD to a non-empty value for the
--        superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

--        You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
--        connections without a password. This is *not* recommended.

--        See PostgreSQL documentation about "trust":
--        https://www.postgresql.org/docs/current/auth-trust.html