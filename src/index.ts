import * as dotenv from 'dotenv';
import * as config from './config';

dotenv.config();

const start = async () => {
  console.log(`Hello World, This is typescript template`);
  console.log(`This is value of example: ${config.app.exampleConfig}`);
};

start();
