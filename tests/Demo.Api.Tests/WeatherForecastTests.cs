namespace Demo.Api.Tests;

public class WeatherForecastTests
{
    [Fact]
    public void Should_Convert_Celsius_To_Fahrenheit()
    {
        var forecast = new WeatherForecast(DateOnly.FromDateTime(DateTime.Now), 0, "summary");
        Assert.Equal(32, forecast.TemperatureF);
    }
}