import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    long[][][] MEMO;
    MEMO.length = 51;
    foreach (ref memo1; MEMO) {
        memo1.length = 51;
        foreach (ref memo2; memo1) {
            memo2.length = (50*50+1);
            foreach (ref memo3; memo2) {
                memo3 = -1;
            }
        }
    }

    auto na = readln.chomp.split(" ").map!(to!int).array;
    auto n = na[0];
    auto a = na[1];

    auto xs = readln.chomp.split(" ").map!(to!int).array;

    long solve(int i, int num, int sum) {
        if (MEMO[i][num][sum] != -1) return MEMO[i][num][sum];
        MEMO[i][num][sum] = i == n ?
            (sum != 0 && sum == num*a ? 1 : 0)
        :
            (solve(i+1, num, sum) + solve(i+1, num+1, sum+xs[i]));

        return MEMO[i][num][sum];
    }
    writeln(solve(0, 0, 0));
}