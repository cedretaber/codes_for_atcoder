import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto it = readln.split.to!(int[]);
    auto A = it[0];
    auto B = it[1];
    auto C = it[2];
    auto X = it[3];
    auto Y = it[4];

    int cost;

    if (A + B > C*2) {
        if (X > Y) {
            cost += 2 * Y * C;
            X -= Y;
            Y = 0;
        } else {
            cost += 2 * X * C;
            Y -= X;
            X = 0;
        }
    } else {
        if (X > Y) {
            cost += A * Y + B * Y;
            X -= Y;
            Y = 0;
        } else {
            cost += A * X + B * X;
            Y -= X;
            X = 0;
        }
    }

    if (X > 0) {
        if (A > C*2) {
            cost += 2 * C * X;
        } else {
            cost += A * X;
        }
    }

    if (Y > 0) {
        if (B > C*2) {
            cost += 2 * C * Y;
        } else {
            cost += B * Y;
        }
    }

    writeln(cost);
}