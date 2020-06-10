import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

enum n0 = BigInt(0);
enum n1 = BigInt(1);
enum n2 = BigInt(2);
enum n3 = BigInt(3);
enum n5 = BigInt(5);

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_t; 0..T) {
        auto nabcd = readln.split.to!(long[]);
        BigInt N = nabcd[0];
        BigInt A = nabcd[1];
        BigInt B = nabcd[2];
        BigInt C = nabcd[3];
        BigInt D = nabcd[4];

        auto memo = [n0: n0, n1: D];
        BigInt solve(BigInt n) {
            if (n !in memo) {
                auto res = n * D;
                res = min(res, solve(n / n2) + A + (n % n2) * D);
                if (n > n2) res = min(res, solve(n / n2 + n1) + A + (n2 - (n % n2)) * D);
                res = min(res, solve(n / n3) + B + (n % n3) * D);
                res = min(res, solve(n / n3 + n1) + B + (n3 - (n % n3)) * D);
                res = min(res, solve(n / n5) + C + (n % n5) * D);
                res = min(res, solve(n / n5 + n1) + C + (n5 - (n % n5)) * D);
                memo[n] = res;
            }
            return memo[n];
        }
        writeln(solve(N));
    }
}