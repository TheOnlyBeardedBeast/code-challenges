import { Pool, PoolClient, QueryConfig } from "pg";
import { Faker, cs_CZ, de, ro } from "@faker-js/faker";

const pool = new Pool({
  user: "code_quest",
  host: "localhost",
  database: "code_quest",
  password: "code_quest",
  port: 5432,
});

enum Country {
  DE = "DE",
  RO = "RO",
  CZ = "CZ",
}

const countryLocale = {
  [Country.DE]: de,
  [Country.RO]: ro,
  [Country.CZ]: cs_CZ,
};

const batch = 1_000_000;

async function generateAndInsertData(client: PoolClient, country: Country) {
  console.log(`Generating and inserting data for ${country}...`);

  try {
    const insertQueries: QueryConfig[] = [];

    const customFaker = new Faker({
      locale: [countryLocale[country]],
    });

    for (let i = 0; i < batch; i++) {
      const firstName = customFaker.person.firstName();
      const lastName = customFaker.person.lastName();
      const address = customFaker.location.streetAddress({
        useFullAddress: true,
      });
      const query: QueryConfig = {
        text: `INSERT INTO users ("firstName", "lastName", "country", "address") VALUES ($1, $2, $3, $4)`,
        values: [firstName, lastName, country, address],
      };
      insertQueries.push(query);
    }

    await client.query("BEGIN");

    for (const query of insertQueries) {
      await client.query(query);
    }

    await client.query("COMMIT");

    console.log(`Successfully inserted data for ${country}`);
  } catch (error) {
    await client.query("ROLLBACK");
    console.error(`Error inserting data for ${country}:`, error);
  }
}

const countries = [Country.DE, Country.RO, Country.CZ];

(async () => {
  try {
    const client = await pool.connect();

    await createTable(client);

    for (const country of countries) {
      await generateAndInsertData(client, country);
    }
    console.log("Finished inserting countries");
    process.exit(0);
  } catch (error) {
    console.error("Error:", error);
  }
})();

async function createTable(client: PoolClient) {
  await client.query(`
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      "firstName" VARCHAR(255) NOT NULL,
      "lastName" VARCHAR(255) NOT NULL,
      "country" VARCHAR(2) NOT NULL,
      "address" VARCHAR(255) NOT NULL
    );
 `);
}
