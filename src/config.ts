import * as dotenv from 'dotenv';

dotenv.config();

export const app = {
  exampleConfig: process.env['EXAMPLE_CONFIG'] || 'example',
};
