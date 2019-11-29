import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

long check(long op, long sum, long[] as)
{
    foreach (a; as) {
        if (sum < 0) {
            if ((sum + a) <= 0) {
                op += (1 - (sum + a));
                sum = 1;
            } else {
                sum += a;
            }
        } else {
            if ((sum + a) >= 0) {
                op += sum + a + 1;
                sum = -1;
            } else {
                sum += a;
            }
        }
    }
    return op;
}

void main()
{
    readln;
    auto as = readln.chomp.split(" ").map!(to!long).array;

    auto op1 = check(0, as[0], as[1..$]);
    auto op2 = check((as[0] - 1).abs, 1, as[1..$]);
    auto op3 = check((as[0] + 1).abs, -1, as[1..$]);

    if (as[0] == 0) op1 = long.max;

    writeln(min(op1, op2, op3));
}