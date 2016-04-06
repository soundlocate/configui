#include "config.h"
#include <iostream>

Config::Config(std::string filename, QObject *parent) : QObject(parent)
{
    m_real = false;
    QObject::connect(this, &Config::configChanged, this, &Config::configHasChanged);

    table = cpptoml::parse_file(filename);
    readConfig();
}

void Config::writeConfig() {
	table->erase("general.samplerate");
	table->erase("general.real");
	table->erase("general.log");
	table->erase("general.logfilename");
	table->erase("general.micPositions");
	table->erase("soundInput.deviceName");
	table->erase("soundSimulate.soundFile");
	table->erase("soundFFT.fftSize");
	table->erase("soundFFT.windowingFunction");
	table->erase("soundFFT.fftPerSec");
  table->erase("soundFFT.threshold");
	table->erase("soundLocate.algorithms");
	table->erase("soundLocate.accuracy");
	table->erase("soundReduce.maxClusterSize");
	table->erase("soundReduce.maxKeep");
	table->erase("soundReduce.meanWindow");
	table->erase("soundReduce.keepTime");

	auto general = cpptoml::make_table();
    general->insert("samplerate", (long) m_samplerate);
	general->insert("real", m_real);
	general->insert("log", m_log);

	if(m_log)
        general->insert("logfilename", m_logfilename.toStdString());


	auto micArray = cpptoml::make_array();
	for(auto m : m_mics) {
		micArray->push_back(m.x);
		micArray->push_back(m.y);
		micArray->push_back(m.z);
	}
	general->insert("micPositions", micArray);
	table->insert("general", general);

	auto soundInput = cpptoml::make_table();
	soundInput->insert("deviceName", m_deviceName.toStdString());
	table->insert("soundInput", soundInput);

	auto soundSimulate = cpptoml::make_table();
    soundSimulate->insert("soundFile", m_soundFile.toLocalFile().toStdString());
    table->insert("soundSimulate", soundSimulate);

	auto soundFFT = cpptoml::make_table();
    soundFFT->insert("fftSize", (long) m_fftSize);

	switch (m_fftFunction) {
	case 0: {
		soundFFT->insert("windowingFunction", "hamm");
		break;
	}
	case 1: {
		soundFFT->insert("windowingFunction", "hann");
		break;
	}
	case 2: {
		soundFFT->insert("windowingFunction", "rect");
		break;
	}
	default:
		soundFFT->insert("windowingFunction", "rect");
		break;
	}

    soundFFT->insert("fftPerSec", (long) m_fftPerSec);
    soundFFT->insert("threshold", m_fftThres);
	table->insert("soundFFT", soundFFT);

	auto soundLocate = cpptoml::make_table();
	soundLocate->insert("accuracy", m_accuracy);

	if(m_algoPhase)
		soundLocate->insert("algorithms", "PhaseOnly");
	else if(m_algoPaV)
		soundLocate->insert("algorithms", "PhaseAndVelocity");
	else if(m_algoPaA)
		soundLocate->insert("algorithms", "PhaseAndAmplitude");

	table->insert("soundLocate", soundLocate);

	auto soundReduce = cpptoml::make_table();
	soundReduce->insert("maxClusterSize", m_maxClusterSize);
    soundReduce->insert("maxKeep", (long) m_maxKeep);
    soundReduce->insert("meanWindow", (long) m_meanWindow);
	soundReduce->insert("keepTime", m_keepTime);

	switch (m_disFunc) {
	case 0: {
		soundReduce->insert("dissimilarityFunction", "meanDist");
		break;
	}
	case 1: {
	  soundReduce->insert("dissimilarityFunction", "meanDirection");
		break;
	}
	default:
		soundReduce->insert("dissimilarityFunction", "meanDirection");
		break;
	}

	table->insert("soundReduce", soundReduce);

    std::ofstream file{"config.toml"};
    file << (*table) << std::flush << std::endl;
	file.close();
}

void Config::readConfig() {
    m_samplerate = *table->get_qualified_as<int64_t>("general.samplerate");
	m_real = *table->get_qualified_as<bool>("general.real");

	m_log = *table->get_qualified_as<bool>("general.log");
    if(m_log) {
        std::string s = *table->get_qualified_as<std::string>("general.logfilename");
        m_logfilename = QString(s.c_str());
    }

    // std::cout << *table << std::endl;

    auto mics = table->get_array_qualified("general.micPositions")->array_of<double>();
    m_mics.clear();

    for(int i = 0; i < mics.size() / 3; i++) {
        Mic m;
        m.x = mics.at(3 * i).get()->get();
        m.y = mics.at(3 * i + 1).get()->get();
        m.z = mics.at(3 * i + 2).get()->get();
        m_mics.append(m);
    }

    std::string s = *table->get_qualified_as<std::string>("soundInput.deviceName");
    m_deviceName = QString(s.c_str());
    s = *table->get_qualified_as<std::string>("soundSimulate.soundFile");
    m_soundFile = QString(s.c_str());
    m_fftSize = *table->get_qualified_as<int64_t>("soundFFT.fftSize");
    s = *table->get_qualified_as<std::string>("soundFFT.windowingFunction");
    QString t(s.c_str());

    if(t == "hamm")
        m_fftFunction = 0;
    else if(t == "hann")
        m_fftFunction = 1;
    else
        m_fftFunction = 2;

    m_fftPerSec = *table->get_qualified_as<int64_t>("soundFFT.fftPerSec");
    m_fftThres = *table->get_qualified_as<double>("soundFFT.threshold");

    s = *table->get_qualified_as<std::string>("soundLocate.algorithms");
    t = QString(s.c_str());

    m_algoPaA = false;
    m_algoPaV = false;
    m_algoPhase = false;

    if(t == "PhaseOnly")
        m_algoPhase = true;
    else if(t == "PhaseAndVelocity")
        m_algoPaV = true;
    else if(t == "PhaseAndAmplitude")
        m_algoPaA = true;

    m_accuracy = *table->get_qualified_as<double>("soundLocate.accuracy");

    m_maxClusterSize = *table->get_qualified_as<double>("soundReduce.maxClusterSize");
    m_maxKeep = *table->get_qualified_as<int64_t>("soundReduce.maxKeep");
    m_meanWindow = *table->get_qualified_as<int64_t>("soundReduce.meanWindow");
    m_keepTime = *table->get_qualified_as<double>("soundReduce.keepTime");

	s = *table->get_qualified_as<std::string>("soundReduce.dissimilarityFunction");
    t = QString(s.c_str());

    if(t == "meanDist")
        m_fftFunction = 0;
    else if(t == "meanDirection")
        m_fftFunction = 1;
    else
        m_fftFunction = 0;
}
