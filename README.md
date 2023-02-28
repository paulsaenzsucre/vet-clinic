<a name="readme-top"></a>

<div align="center">
  <img src="./logo.svg" alt="logo" width="256"  height="auto" />
  <br/>

  <h3><b>VET CLINIC</b></h3>

</div>

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [Schema Diagram](#schema)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [📝 License](#license)

# 📖 Vet Clinic <a name="about-project"></a>

**Vet Clinic** is a project in wich, I will use a relational database to create the initial data structure for a vet clinic. I will create a table to store animals' information, insert some data into it, and query it.

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

This is a database only project.

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>

### Key Features <a name="key-features"></a>

You can use sql to mutate the database state.

- **You can add animals**
- **You can edit animals data**
- **You can show animals data**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🛠 Schema Diagram <a name="schema"></a>

<div align="center">
  <img src="./vet_clinic.png" alt="schema" width="auto"  height="auto" />
  <br/>

  <h3><b>VET CLINIC SCHEMA DIAGRAM</b></h3>

</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 💻 Getting Started <a name="getting-started"></a>

This repository includes files with plain SQL that can be used to recreate a database:

- Use [schema.sql](./schema.sql) to create all tables.
- Use [data.sql](./data.sql) to populate tables with sample data.
- Check [queries.sql](./queries.sql) for examples of queries that can be run on a newly created database. **Important note: this file might include queries that make changes in the database (e.g., remove records). Use them responsibly!**

To get a local copy up and running, follow these steps.

### Prerequisites

- [ ] You’ll need to have PostgreSQL on your machine.

### Setup

To clone this repository to your desired folder:

- You can download the **Zip** file from the GitHub repository, or clone the repository with:

```console
git clone https://github.com/paulsaenzsucre/vet-clinic.git
```

- Access the cloned directory with:

```console
cd vet-clinic
```

- Open it with your favorite code editor or with the live server
### Install

To recreate the database use the following comand:

```console
psql -U username -f schema.sql
psql -U username -f data.sql
psql -U username -f queries.sql
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 👥 Authors <a name="authors"></a>

👤 **Birhanu Gudisa**

- GitHub: [@GutemaG](https://github.com/GutemaG)
- Twitter: [@birhanugudisa3](https://twitter.com/birhanugudisa3)
- LinkedIn: [birhanugudisa](https://linkedin.com/in/birhanugudisa)

👤 **Paul Sáenz Sucre**

- GitHub: [@paulsaenzsucre](https://github.com/paulsaenzsucre)
- Twitter: [@paulsaenzsucre](https://twitter.com/paulsaenzsucre)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/paulsaenzsucre)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🔭 Future Features <a name="future-features"></a>

- [ ] **Add vets, specialties and visits tables**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## ⭐️ Show your support <a name="support"></a>

Give a ⭐️ if you like this project!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🙏 Acknowledgments <a name="acknowledgements"></a>

- Hat tip to anyone whose code was used.
- Thanks for all the curated content that was provided to us.
- Thanks to my learning and coding partners for all their support.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>