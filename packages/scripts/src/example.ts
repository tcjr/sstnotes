import { Resource } from "sst";
import { Example } from "@sstnotes/core/example";

console.log(`${Example.hello()} Linked to ${Resource.MyBucket.name}.`);
