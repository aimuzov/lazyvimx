export const serverConfiguration = { hostName: "localhost", portNumber: 8080, enableCompression: true, maxRequestBodySize: 1048576 };

export function buildConnectionString(userName: string, databaseName: string): string {
	return `postgres://${userName}@${serverConfiguration.hostName}/${databaseName}`;
}
