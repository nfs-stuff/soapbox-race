package br.com.soapboxrace.engine;

import br.com.soapboxrace.achievements.AchievementQueue;
import br.com.soapboxrace.achievements.AchievementUpdateInfo;
import br.com.soapboxrace.achievements.AchievementUtils;
import br.com.soapboxrace.bo.DriverPersonaBO;
import br.com.soapboxrace.dao.factory.DaoFactory;
import br.com.soapboxrace.definition.ServerExceptions;
import br.com.soapboxrace.definition.ServerExceptions.PersonaIdMismatchException;
import br.com.soapboxrace.jaxb.*;
import br.com.soapboxrace.jaxb.util.MarshalXML;
import br.com.soapboxrace.jaxb.util.UnmarshalXML;
import br.com.soapboxrace.jpa.PersonaEntity;
import br.com.soapboxrace.utils.MiscUtils;
import br.com.soapboxrace.utils.Pools;

import java.util.List;
import java.util.Queue;
import java.util.concurrent.TimeUnit;

public class DriverPersona extends Router {

	private DriverPersonaBO driverPersonaBO = new DriverPersonaBO();

	private Long getPersonaId(boolean isBypass) throws PersonaIdMismatchException {
		String personaIdStr = getParam("personaId");
		Long personaId = Long.valueOf(personaIdStr);
		if (((personaId.equals(getLoggedPersonaId()) || getLoggedPersonaId() == -1L)) || isBypass)
			if (getUserId() != -1L && !getSecurityToken().isEmpty()
					&& Router.activeUsers.get(getUserId()).getSecurityToken().equals(getSecurityToken()))
				return personaId;
		throw new ServerExceptions.PersonaIdMismatchException(getLoggedPersonaId(), personaId);
	}
	
	private Long getPlainPersonaId() {
		return Long.valueOf(getParam("personaId"));
	}
	
	private long getPersonaId() throws PersonaIdMismatchException {
		return getPersonaId(false);
	}

	public String getExpLevelPointsMap() {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("<ArrayOfint>\n");
		stringBuilder.append("  <int>100</int>\n");
		stringBuilder.append("  <int>975</int>\n");
		stringBuilder.append("  <int>2025</int>\n");
		stringBuilder.append("  <int>3625</int>\n");
		stringBuilder.append("  <int>5875</int>\n");
		stringBuilder.append("  <int>8875</int>\n");
		stringBuilder.append("  <int>12725</int>\n");
		stringBuilder.append("  <int>17525</int>\n");
		stringBuilder.append("  <int>23375</int>\n");
		stringBuilder.append("  <int>30375</int>\n");
		stringBuilder.append("  <int>39375</int>\n");
		stringBuilder.append("  <int>50575</int>\n");
		stringBuilder.append("  <int>64175</int>\n");
		stringBuilder.append("  <int>80375</int>\n");
		stringBuilder.append("  <int>99375</int>\n");
		stringBuilder.append("  <int>121375</int>\n");
		stringBuilder.append("  <int>146575</int>\n");
		stringBuilder.append("  <int>175175</int>\n");
		stringBuilder.append("  <int>207375</int>\n");
		stringBuilder.append("  <int>243375</int>\n");
		stringBuilder.append("  <int>283375</int>\n");
		stringBuilder.append("  <int>327575</int>\n");
		stringBuilder.append("  <int>376175</int>\n");
		stringBuilder.append("  <int>429375</int>\n");
		stringBuilder.append("  <int>487375</int>\n");
		stringBuilder.append("  <int>550375</int>\n");
		stringBuilder.append("  <int>618575</int>\n");
		stringBuilder.append("  <int>692175</int>\n");
		stringBuilder.append("  <int>771375</int>\n");
		stringBuilder.append("  <int>856375</int>\n");
		stringBuilder.append("  <int>950875</int>\n");
		stringBuilder.append("  <int>1055275</int>\n");
		stringBuilder.append("  <int>1169975</int>\n");
		stringBuilder.append("  <int>1295375</int>\n");
		stringBuilder.append("  <int>1431875</int>\n");
		stringBuilder.append("  <int>1579875</int>\n");
		stringBuilder.append("  <int>1739775</int>\n");
		stringBuilder.append("  <int>1911975</int>\n");
		stringBuilder.append("  <int>2096875</int>\n");
		stringBuilder.append("  <int>2294875</int>\n");
		stringBuilder.append("  <int>2506375</int>\n");
		stringBuilder.append("  <int>2731775</int>\n");
		stringBuilder.append("  <int>2971475</int>\n");
		stringBuilder.append("  <int>3225875</int>\n");
		stringBuilder.append("  <int>3495375</int>\n");
		stringBuilder.append("  <int>3780375</int>\n");
		stringBuilder.append("  <int>4081275</int>\n");
		stringBuilder.append("  <int>4398475</int>\n");
		stringBuilder.append("  <int>4732375</int>\n");
		stringBuilder.append("  <int>5083375</int>\n");
		stringBuilder.append("  <int>5481355</int>\n");
		stringBuilder.append("  <int>5898805</int>\n");
		stringBuilder.append("  <int>6336165</int>\n");
		stringBuilder.append("  <int>6793875</int>\n");
		stringBuilder.append("  <int>7272375</int>\n");
		stringBuilder.append("  <int>7772105</int>\n");
		stringBuilder.append("  <int>8293505</int>\n");
		stringBuilder.append("  <int>8837015</int>\n");
		stringBuilder.append("  <int>9403075</int>\n");
		stringBuilder.append("  <int>9992125</int>\n");
		stringBuilder.append("</ArrayOfint>");
		return stringBuilder.toString();
	}

	public String reserveName() {
		ArrayOfstringType reserveName = driverPersonaBO.reserveName(getParam("name"));
		return MarshalXML.marshal(reserveName);
	}

	public String unreserveName() {
		return "";
	}

	public String createPersona() {
		String userIdStr = getParam("userId");
		String name = getParam("name");
		String iconIndexStr = getParam("iconIndex");
		ProfileDataType createPersona = driverPersonaBO.createPersona(Long.valueOf(userIdStr), name,
				Integer.valueOf(iconIndexStr));
		return MarshalXML.marshal(createPersona);
	}

	public String getPersonaInfo() throws PersonaIdMismatchException {
		Long loggedPersonaId = getLoggedPersonaId();
		PersonaEntity persona = DaoFactory.getPersonaDao().findById(loggedPersonaId);
		
        AchievementQueue.PersonaAchievementQueue queue = AchievementQueue.get(loggedPersonaId);
        
		if (queue.isDirty()) {
            Pools.scheduler.schedule(() -> {
                while (queue.isFree()) {
//				    System.out.println("[queue-" + loggedPersonaId + "] waiting for queue to be locked");
                    MiscUtils.noop();
                }

			    System.out.println("[queue-" + loggedPersonaId + "] queue is locked, proceeding");

                Queue<AchievementUpdateInfo> updateInfoQueue = queue.getUpdateInfoQueue();

                if (!updateInfoQueue.isEmpty()) {
                    int index = 0;
                    AchievementUpdateInfo updateInfo;

                    while ((updateInfo = updateInfoQueue.poll()) != null) {
                        System.out.println("[queue-" + loggedPersonaId + "] broadcasting update #" + (index + 1));
                        AchievementUtils.broadcastProgress(persona, updateInfo.getPersonaAchievement(), updateInfo.getRanks(), updateInfo.getScore());

                        index++;
                    }
                }

                System.out.println("[queue-" + loggedPersonaId + "] all done, unlocking queue");
                queue.unlock();
            }, 1L, TimeUnit.SECONDS);
        }
		
		ProfileDataType personaInfo = driverPersonaBO.getPersonaInfo(getPersonaId(true));
		return MarshalXML.marshal(personaInfo);
	}

	public String getPersonaBaseFromList() {
		PersonaIdArrayType personaIdArrayType = new PersonaIdArrayType();
		String xmlTmp = readInputStream();
		xmlTmp = xmlTmp.replace(":long", "");
		personaIdArrayType = (PersonaIdArrayType) UnmarshalXML.unMarshal(xmlTmp, personaIdArrayType);
		PersonaIdsType personaIds = personaIdArrayType.getPersonaIds();
		List<Long> personasIds = personaIds.getArray();
		return MarshalXML.marshal(driverPersonaBO.getPersonaBaseFromList(personasIds));
	}

	public String updatePersonaPresence() {
		return "";
	}

	public String deletePersona() throws PersonaIdMismatchException {
		Long idPersona = getPersonaId();
		driverPersonaBO.deletePersona(idPersona);
		return "<long>0</long>";
	}

	public String updateStatusMessage() throws ServerExceptions.EngineException
	{
		String mottoXml = readInputStream();
		PersonaMottoType personaMottoType = new PersonaMottoType();
		personaMottoType = (PersonaMottoType) UnmarshalXML.unMarshal(mottoXml, personaMottoType);
		String message = personaMottoType.getMessage();
		Long personaId = personaMottoType.getPersonaId();
		return MarshalXML.marshal(driverPersonaBO.updateStatusMessage(personaId, message));
	}

	public String getPersonaPresenceByName() throws ServerExceptions.EngineException
	{
		return MarshalXML.marshal(driverPersonaBO.getPersonaPresenceByName(getParam("displayName")));
	}
}