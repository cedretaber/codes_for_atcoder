import std.stdio, std.algorithm, std.conv, std.array, std.string;

int ketasum(int n)
{
    int sum;
    do {
        sum += n % 10;
    } while (n/=10);
    return sum;
}

void main()
{
    int N, A, B;
    readf("%d %d %d", &N, &A, &B);
    int sum;
    foreach (i; 1..N+1) {
        auto s = ketasum(i);
        if (A <= s && s <= B) sum += i;
    }
    writeln(sum);
}